//
//  Staff+CoreDataProperties.swift
//  ReleationData
//
//  Created by nabinrai on 8/4/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import Foundation
import CoreData


extension Staff {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Staff> {
        return NSFetchRequest<Staff>(entityName: "Staff")
    }

    @NSManaged public var id: Int32
    @NSManaged public var fullName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var department: Department?

}
