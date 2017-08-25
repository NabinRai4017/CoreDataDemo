# CoreDataDemo

This is simple usage of core data.

Create entity and its attributes as shown below:
This is an entity for department and its attributes.
![screen shot 2017-08-25 at 12 52 30 pm](https://user-images.githubusercontent.com/28722125/29703191-393c3616-8994-11e7-9aca-0fafe7352a11.png)

This is an entity for staff and its attributes.
![screen shot 2017-08-25 at 12 52 43 pm](https://user-images.githubusercontent.com/28722125/29703189-392fedfc-8994-11e7-8497-2e7409bec69d.png) 
Create relationship between department and staff.

Select both entities and goto Editor and select "Create NSManagedObject Subclass" as shown below:
![screen shot 2017-08-25 at 12 53 52 pm](https://user-images.githubusercontent.com/28722125/29703190-3934e87a-8994-11e7-820d-adfac367a5e4.png)



#### Model

Model for department

    class DepartmentModel {
        var id: Int = 0
        var departmentName: String?

        init(dname: String , id: Int) {
            self.departmentName = dname
            self.id = id
        }
    }
    
Model for staff

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



#### NSFetchedResultsController for core data

    func attemptDepartFetch() -> NSFetchedResultsController<Department>!{

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


#### Save department

    func addDepartMent(departMentModel: DepartmentModel){
        
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
        
    }



#### Get all departments

    func getAllDeparts() ->[Department]?{
        
        let request: NSFetchRequest<Department> = Department.fetchRequest()
        do{
            let departs = try managedObjectcontext.fetch(request)
            return departs
        }catch{
            print("Total Count Read Error")
        }
        return nil
    }

#### Delete department by its id

    func deleteDepartment(id: Int){
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
    

#### Delete all departments

    func deleteAllDeparts()  {
        
        do {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Department")
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            try managedObjectcontext.execute(request)
            
        }catch {
            return
        }
        appDelegate.saveContext()
    }






### This is output of this demo.

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/28722125/29702623-c4497b2c-8991-11e7-9873-3afa22ada9d3.gif) ![ezgif com-video-to-gif-2](https://user-images.githubusercontent.com/28722125/29702624-c44c7b56-8991-11e7-9589-3af26a182c7a.gif) 
