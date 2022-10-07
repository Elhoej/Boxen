//
//  PilleModerl.swift
//  Boxen
//
//  Created by Simon Elhøj Steinmejer on 08/11/2020.
//

import Foundation
import Parse

class Pill: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "Pill"
    }

    @NSManaged var name: String
    @NSManaged var timeList: [String]
    @NSManaged var shape: String
    @NSManaged var user: User
    @NSManaged var dosage: String
    @NSManaged var timesADay: Int
    @NSManaged var time: String
}

class User: PFUser {

    @NSManaged var role: String

}

class PillConsumption: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "PillConsumption"
    }

    @NSManaged var user: User
    @NSManaged var pill: Pill

}

//enum PillColor: String {
//    case purple
//    case gray
//    case blue
//    case red
//}

enum PillShape: String {
    case round
    case oval
    case long
    case rectangle
    case square
    case tabs
    case syringe
    case liquid
}
