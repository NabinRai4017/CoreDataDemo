//
//  StaffDetailVC.swift
//  ReleationData
//
//  Created by nabinrai on 8/18/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import UIKit

class StaffDetailVC: UIViewController {
    
    var staffInfo: Staff!
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var departLbl: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configData()
    }
    
    
    func configData(){
        
        idLbl.text = staffInfo.id.description
        nameLbl.text = staffInfo.fullName
        phoneLbl.text = staffInfo.phoneNumber
        departLbl.text = staffInfo.department?.departmentName ?? "nil"
    }
   

}
