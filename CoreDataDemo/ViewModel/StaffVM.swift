//
//  StaffVM.swift
//  ReleationData
//
//  Created by nabinrai on 8/4/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import Foundation
import CoreData


class StaffModel{
    
    var id: Int?
    var fullName: String?
    var phoneNumber: String?
    var department: Department?
    
    init(id: Int, fullname: String, phone: String, depart: Department?) {
        
        self.id = id
        self.fullName = fullname
        self.phoneNumber = phone
        self.department = depart
    }
    
}

class StaffVM{
    
    
    
    class func attemptStaffFetch() -> NSFetchedResultsController<Staff>!{
        
        let fetchRequest: NSFetchRequest<Staff> = Staff.fetchRequest()
        
        // sorting
        let nameSort = NSSortDescriptor(key: "id", ascending: false)
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
    
    class func attemptStaffFetchWithDepartID(_departID: Int32) -> NSFetchedResultsController<Staff>!{
        
        let fetchRequest: NSFetchRequest<Staff> = Staff.fetchRequest()
        
        // sorting
        let nameSort = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [nameSort]
        fetchRequest.predicate = NSPredicate(format: "department.id == \(_departID)")
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectcontext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try controller.performFetch()
            
        } catch{
            let error = error as NSError
            print(error)
        }
        return controller
    }
    
    
    class func addStaff(newStaff: StaffModel){
        
        let staff:Staff!
        if #available(iOS 10.0, *) {
            staff = Staff(context: managedObjectcontext)
        }else{
            let entityDescription = NSEntityDescription.entity(forEntityName: "Staff", in: managedObjectcontext)
            staff = NSManagedObject(entity:entityDescription!, insertInto: managedObjectcontext) as! Staff
        }
        
        staff.fullName = newStaff.fullName
        staff.id = Int32(newStaff.id!)
        staff.phoneNumber = newStaff.phoneNumber
        staff.department = newStaff.department
        managedObjectcontext.insert(staff)
        appDelegate.saveContext()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
    
    
 
    //MARK: Deleting from cart
    class func deleteAllStaffs()  {
        
        do {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Staff")
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            try managedObjectcontext.execute(request)
            
        }catch {
            
            return
        }
        appDelegate.saveContext()
    }
    
    
    //MARK: getSatffs
    class func getAllStaffs()->(count:Int,staffs:[StaffModel])?{
        
        var count:Int = 0
        var staffs:[StaffModel] = []
        let request: NSFetchRequest<Staff> = Staff.fetchRequest()
        do{
            let stafs = try managedObjectcontext.fetch(request)
            for staff in stafs{
                count += 1
                let stt = StaffModel(id: Int(staff.id), fullname: staff.fullName!, phone: staff.phoneNumber!, depart: staff.department!)
                staffs.append(stt)
            }
            return (count, staffs)
        }catch{
            print("Total Count Read Error")
        }
        return nil
    }
    
    
    class func deleteStaff(id: Int){
        let request: NSFetchRequest<Staff> = Staff.fetchRequest()
        let predicate = NSPredicate(format: "id = %i", id)
        request.predicate = predicate
        do{
            let staffs = try managedObjectcontext.fetch(request)
            for staff in staffs{
                managedObjectcontext.delete(staff)
            }
            appDelegate.saveContext()
        }catch{
            print("error while removing")
        }
    }
    
    
    class func saveAfterEdit(editStaff:Staff){
        var staff:Staff!
        if #available(iOS 10.0, *) {
            staff = Staff(context: managedObjectcontext)
        }else{
            let entityDescription = NSEntityDescription.entity(forEntityName: "Staff", in: managedObjectcontext)
            staff = NSManagedObject(entity:entityDescription!, insertInto: managedObjectcontext) as! Staff
        }
        staff = editStaff
        managedObjectcontext.insert(staff)
        appDelegate.saveContext()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }

    
}
