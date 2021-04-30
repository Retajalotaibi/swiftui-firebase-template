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
    @Published var alertShown = false
    @Published var alertMessage = ErrorMessages.none.message
    
    func loadItems(){
        Networking.getListOf(COLLECTION_NAME: "\(collectionName)/\(Networking.getUserId()!)/data") { (items: [Course]) in
            self.course = items
        }
    }
    
    func addItem(item: Course){
        
        Networking.createItemDoc(item, inCollection: "\(collectionName)/\(Networking.getUserId()!)/data", documentName: "/\(item.name)") {
            self.showAlert(alertType: .success)
        }
//        } fail: { (error) in
//            self.showAlert(alertType: .fail)
//        }
    }
    func addClass(userClass: Classes, courseName: String){
        Networking.createItemDoc(userClass, inCollection: "\(collectionName)/\(Networking.getUserId()!)/data/\(courseName)/classes", documentName: "/\(userClass.name)") {
            self.showAlert(alertType: .success)
        }
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
