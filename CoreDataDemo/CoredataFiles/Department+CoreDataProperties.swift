//
//  Department+CoreDataProperties.swift
//  ReleationData
//
//  Created by nabinrai on 8/18/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var departmentName: String?
    @NSManaged public var id: Int32
    @NSManaged public var staff: NSSet?

}

// MARK: Generated accessors for staff
extension Department {

    @objc(addStaffObject:)
    @NSManaged public func addToStaff(_ value: Staff)

    @objc(removeStaffObject:)
    @NSManaged public func removeFromStaff(_ value: Staff)

    @objc(addStaff:)
    @NSManaged public func addToStaff(_ values: NSSet)

    @objc(removeStaff:)
    @NSManaged public func removeFromStaff(_ values: NSSet)

}
