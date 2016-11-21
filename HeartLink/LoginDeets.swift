//
//  LoginDeets.swift
//  
//
//  Created by User on 11/11/2016.
//
//

import Foundation
import CoreData

class LoginDeets: NSManagedObject {

    @NSManaged var convoID: String
    @NSManaged var emrID: String
    @NSManaged var gameification: String
    @NSManaged var networkID: String
    @NSManaged var patientID: String
    @NSManaged var tokenID: String
    @NSManaged var username: String
    @NSManaged var password: String

}
