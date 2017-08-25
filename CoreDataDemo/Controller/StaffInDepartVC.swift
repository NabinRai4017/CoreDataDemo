//
//  StaffInDepartVC.swift
//  ReleationData
//
//  Created by nabinrai on 8/18/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import UIKit
import CoreData

class StaffInDepartVC: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var departInfo: Department!
    
    var controller : NSFetchedResultsController<Staff>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print( departInfo.id)
        self.controller = StaffVM.attemptStaffFetchWithDepartID(_departID: departInfo.id)
        self.controller.delegate = self

       
    }

  
    // core data to update table
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .delete:
            
            if let indeXpath = indexPath{
                tableView.deleteRows(at: [indeXpath], with: .fade)
            }
            break
        case .insert:
            
            if let indeXpath = newIndexPath{
                tableView.insertRows(at: [indeXpath], with: .fade)
            }
            break
        case .update:
            
            if let indeXpath = indexPath{
                let cell = tableView.cellForRow(at: indeXpath)!
                configureCell(cell: cell, indexPath: indeXpath)
            }
            break
        case .move:
            if let indeXpath = indexPath{
                tableView.deleteRows(at: [indeXpath], with: .fade)
            }
            if let indeXPath = newIndexPath{
                tableView.insertRows(at: [indeXPath], with: .fade)
            }
            break
        }
    }
    
    
    
    
    
    
    //MARK: Extension tableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    func configureCell(cell: UITableViewCell, indexPath: IndexPath){
        let item = controller.object(at: indexPath as IndexPath)
        cell.textLabel?.text = "Id: \(item.id) Name: " + item.fullName!
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(String(describing: departInfo.departmentName!.uppercased()))'S STAFFS"
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let staffDetailVC = storyboard.instantiateViewController(withIdentifier: "StaffDetailVC") as! StaffDetailVC
        staffDetailVC.staffInfo = controller.object(at: indexPath)
        self.navigationController?.pushViewController(staffDetailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            let staff = self.controller.object(at: indexPath)
            StaffVM.deleteStaff(id: Int(staff.id))
            print("Delete tapped")
            
        })
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
        
    }
}
