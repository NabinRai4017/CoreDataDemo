//
//  DepartmentVM.swift
//  ReleationData
//
//  Created by nabinrai on 8/4/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import Foundation
import  CoreData

class DepartmentModel {
    var id: Int = 0
    var departmentName: String?
    
    init(dname: String , id: Int) {
        self.departmentName = dname
        self.id = id
    }
}

class DepartmentVM {
    

    class func attemptDepartFetch() -> NSFetchedResultsController<Department>!{
        
        let fetchRequest: NSFetchRequest<Department> = Department.fetchRequest()
        
        // sorting
        let nameSort = NSSortDescriptor(key: "departmentName", ascending: false)
        fetchRequest.sortDescriptors = [nameSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectcontext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try controller.performFetch()
            
        } catch{
            let error = error as NSError
            print(error)
        }
        return controller
    }
    
    
    
    class func addDepartMent(departMentModel: DepartmentModel){
        
        let depart:Department!
        if #available(iOS 10.0, *) {
            depart = Department(context: managedObjectcontext)
        }else{
            let entityDescription = NSEntityDescription.entity(forEntityName: "Department", in: managedObjectcontext)
            depart = NSManagedObject(entity:entityDescription!, insertInto: managedObjectcontext) as! Department
        }
        depart.id = Int32(departMentModel.id)
        depart.departmentName = departMentModel.departmentName
        managedObjectcontext.insert(depart)
        appDelegate.saveContext()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
    }
    
    class func getAllDeparts() ->[Department]?{
        
        let request: NSFetchRequest<Department> = Department.fetchRequest()
        do{
            let departs = try managedObjectcontext.fetch(request)
            return departs
        }catch{
            print("Total Count Read Error")
        }
        return nil
    }
    
    //MARK: Deleting
    class func deleteAllDeparts()  {
        
        do {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Department")
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            try managedObjectcontext.execute(request)
            
        }catch {
            return
        }
        appDelegate.saveContext()
    }
    
    
    class func deleteDepartment(id: Int){
        let request: NSFetchRequest<Department> = Department.fetchRequest()
        let predicate = NSPredicate(format: "id = %i", id)
        request.predicate = predicate
        do{
            let departs = try managedObjectcontext.fetch(request)
            for depart in departs{
                managedObjectcontext.delete(depart)
            }
            appDelegate.saveContext()
        }catch{
            print("error while removing")
        }
    }
    
    
    class func saveAfterEdit(restaurant:Department){
        var depart:Department!
        if #available(iOS 10.0, *) {
            depart = Department(context: managedObjectcontext)
        }else{
            let entityDescription = NSEntityDescription.entity(forEntityName: "Department", in: managedObjectcontext)
            depart = NSManagedObject(entity:entityDescription!, insertInto: managedObjectcontext) as! Department
        }
        depart = restaurant
        managedObjectcontext.insert(depart)
        appDelegate.saveContext()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }

}
