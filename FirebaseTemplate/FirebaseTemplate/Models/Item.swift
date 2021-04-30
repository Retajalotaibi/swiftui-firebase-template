//
//  Item.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import Foundation


struct Item: Codable, Hashable{
    var name: String
    var price: Double
}

struct Course: Codable, Hashable {
    var name: String
    var startDay: String
    var endDay: String
//    var classed: [Classes]
}

struct Classes: Codable, Hashable {
    var name : String
    var color: String
    var dates: [String]
    var time: String
//    var tasks: [Tasks]
}

struct Tasks: Codable, Hashable  {
    var taskName: String
    var due: String
}
