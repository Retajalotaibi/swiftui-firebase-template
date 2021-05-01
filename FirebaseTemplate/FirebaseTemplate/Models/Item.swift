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
    var id: String
    var name: String
    var startDay: String
    var endDay: String
//   var classed: [Classes]
//    enum CodingKeys: String, CodingKey {
//        case name ,startDay,endDay
//    }
}

struct Classes: Identifiable,Codable, Hashable {
    var id: String
    var name : String
    var color: String
    var dates: [String]
    var time: [String]
//    enum CodingKeys: String, CodingKey {
//        case name ,color,dates,time
//    }
}

struct Tasks:Codable, Hashable  {
    var taskName: String
    var due: String

}

struct Notifications : Codable, Hashable{
    var leacterTime: [String]
    var taskDueAt: String
}
