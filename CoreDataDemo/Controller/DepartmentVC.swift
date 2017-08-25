//
//  ViewController.swift
//  ReleationData
//
//  Created by nabinrai on 8/4/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import UIKit
import CoreData

class DepartmentVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    
    @IBOutlet weak var departmentTxtfield: UITextField!
   
    var controller : NSFetchedResultsController<Department>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        self.controller = DepartmentVM.attemptDepartFetch()
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
                if let cell = tableView.cellForRow(at: indeXpath){
                    configureCell(cell: cell, indexPath: indeXpath)
                }
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
    
    
    
    
    
    @IBAction func addDepart(_ sender: UIBarButtonItem) {
        
        guard  let departName = departmentTxtfield.text,departName != "" else {
            return
        }
        let randomNumber = Int(arc4random_uniform(100))
        let depart = DepartmentModel(dname: departName.uppercased(), id: randomNumber)
        DepartmentVM.addDepartMent(departMentModel: depart)
        departmentTxtfield.text = ""
        
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
        cell.textLabel?.text = "ID: \(item.id)  Department name: "+item.departmentName!
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "DEPARTMENTS"
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let staffDetailVC = storyboard.instantiateViewController(withIdentifier: "StaffInDepartVC") as! StaffInDepartVC
        staffDetailVC.departInfo = controller.object(at: indexPath)
        self.navigationController?.pushViewController(staffDetailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            let depart = self.controller.object(at: indexPath)
            DepartmentVM.deleteDepartment(id: Int(depart.id))
            print("Delete tapped")
            
        })
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
        
    }

    
}

