//
//  Patient.swift
//  
//
//  Created by User on 11/11/2016.
//
//

import Foundation
import CoreData

class Patient: NSManagedObject {

    @NSManaged var alcohol: String
    @NSManaged var date: String
    @NSManaged var diastolic: String
    @NSManaged var heartRate: String
    @NSManaged var smoke: String
    @NSManaged var steps: String
    @NSManaged var stress: String
    @NSManaged var systolic: String
    @NSManaged var weight: String

}
