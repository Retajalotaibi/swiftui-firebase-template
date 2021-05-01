//
//  ItemsEnv.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

class ItemsEnv: ObservableObject{
    let collectionName = "course"

    @Published var course: [Course] = []
    @Published var classes: [Classes] = []
    @Published var tasks: [Tasks] = []
    @Published var alertShown = false
    @Published var alertMessage = ErrorMessages.none.message
    
    func loadItems(){
        //print("😭\(item.id)")
        Networking.getListOf(COLLECTION_NAME: "\(collectionName)/\(Networking.getUserId()!)/data") { (items: [Course]) in
            self.course = items
        }
    }
    func loadClass(courseName: String){
        Networking.getListOf(COLLECTION_NAME: "\(collectionName)/\(Networking.getUserId()!)/data/\(courseName)/classes") { (items: [Classes]) in
            self.classes = items
        }
    }
    func addItem(item: Course){
        
        
        Networking.createItemDoc(item, inCollection: "\(collectionName)/\(Networking.getUserId()!)/data", documentName: "/\(item.id)") {
            self.showAlert(alertType: .success)
        }
//        } fail: { (error) in
//            self.showAlert(alertType: .fail)
//        }
    }
    func addClass(userClass: Classes, courseName: String){
       
        Networking.createItemDoc(userClass, inCollection: "\(collectionName)/\(Networking.getUserId()!)/data/\(courseName)/classes", documentName: "/\(userClass.id)") {
            self.showAlert(alertType: .success)
        }
    }
    
    func addTask(task: Tasks,userClass: String, courseName: String){
        Networking.createItem(task, inCollection: "\(collectionName)/\(Networking.getUserId()!)/data/\(courseName)/classes/\(userClass)/tasks") {
            self.showAlert(alertType: .fail)
        }
//        Networking.createItemDoc(task, inCollection: ) {
//            self.showAlert(alertType: .success)
//        }
    }
    
    func loadTask(userClass: String, courseName: String){
        print(userClass,courseName)
        Networking.getListOf(COLLECTION_NAME: "\(collectionName)/\(Networking.getUserId()!)/data/\(courseName)/classes/\(userClass)/tasks") { (items: [Tasks]) in
            self.tasks = items
        }
    }
    func createNotifications(module:Notifications){
        
        Networking.createItemDoc(module, inCollection: "Notifications/\(Networking.getUserId()!)/data/") {
            self.showAlert(alertType: .success)
        }
    }
    func getAllClasses() -> [Classes]{
        var allCourses: [Course] = []
        var classess: [Classes] = []
        loadItems()
        allCourses = self.course
        print(allCourses)
        
//                 Networking.getListOf(COLLECTION_NAME: "\(collectionName)/\(Networking.getUserId()!)/data")  { (items: [Course]) in
//                    allCourses = items
//                }
//
//
//                print("❌", allCourses)
//                for i in allCourses{
//                    Networking.getDocumentOfCollection(DOCUMENT_PATH: "\(collectionName)/\(Networking.getUserId()!)/data/\(i.id)") { (items: [Classes]) in
//                        classess = items
//                    }
//                }
        
        return classess
    }
    
    enum ErrorMessages{
        case success, fail, none, incompleteForm
        var message: String{
            switch self{
            case .success: return "a courses has been added"
            case .incompleteForm: return "fill every thing"
            case .fail: return "there was an error"
            case .none: return ""
            }
        }
    }
    
    func showAlert(alertType: ErrorMessages){
        self.alertMessage = alertType.message
        self.alertShown = true
    }

    
}
