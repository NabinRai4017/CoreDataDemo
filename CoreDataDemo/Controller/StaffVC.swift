//
//  StaffVC.swift
//  ReleationData
//
//  Created by nabinrai on 8/4/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import UIKit

class AddStaffVC: UIViewController {
    
    var staffTableVC: StaffTableVC!

    
    @IBOutlet weak var staffName: UITextField!
    @IBOutlet weak var staffContact: UITextField!
    @IBOutlet weak var departmentPicker: UIPickerView!
    
    
    
    var departMents:[Department]? = {
        
        if let departs = DepartmentVM.getAllDeparts(){
            print(departs.count)
            return departs
        }
        return nil
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departmentPicker.delegate = self
        departmentPicker.dataSource = self
        departmentPicker.reloadAllComponents()
    }

   
    
    
    @IBAction func addStaff(_ sender: UIButton) {
        
        guard  let name = staffName.text, let contact = staffContact.text, name != "", contact != "" else {
            print("Empty fields")
            return
        }
        var new: StaffModel!
        let randomNumber = Int(arc4random_uniform(100))
        let index = departmentPicker.selectedRow(inComponent: 0)
        print(index)
        if !(departMents?.isEmpty)!, let depart = departMents?[index]{
            new = StaffModel(id: randomNumber, fullname: name.uppercased(), phone: contact.uppercased(), depart: depart)
        }else{
            new = StaffModel(id: randomNumber, fullname: name.uppercased(), phone: contact.uppercased(), depart: nil)
        }
        StaffVM.addStaff(newStaff: new)
        self.navigationController?.popViewController(animated: true)
        
    }
    

}

extension AddStaffVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return departMents!.count
        
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return departMents?[row].departmentName
    }
    
    
    
    
    
}
