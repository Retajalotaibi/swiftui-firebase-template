//
//  AddItem.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct AddItem: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    @State var itemName: String = ""
    @State var itemPrice: String = ""
    @State private var startDay = Date()
    @State private var endDay = Date()
    @State var formattedStartDay = ""
    @State var formattedEndDay = ""
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        return formatter
    }
    var body: some View {
        VStack {
            TextField("course name", text: $itemName)

            DatePicker("course start at",selection: $startDay, displayedComponents: .date).foregroundColor(.secondary)
            DatePicker("course end at",selection: $endDay, displayedComponents: .date).foregroundColor(.secondary)
            Button(action: {
                
                self.formattedStartDay = dateFormatter.string(from: startDay)
                self.formattedEndDay = dateFormatter.string(from: endDay)
                print("❌\(self.formattedStartDay), \(self.formattedEndDay) ,😳 \(itemName) ")
                let course = Course(name: itemName, startDay: formattedStartDay, endDay: formattedEndDay)

                itemsEnv.addItem(item: course)

            }, label: {
                Text("Add Item").frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule()).padding()
                Spacer()
            })
            Spacer()
        }
        .navigationTitle("Add a new course")
        .padding()
        .padding(.top , 20)
        .alert(isPresented: $itemsEnv.alertShown, content: {
            Alert(title: Text(itemsEnv.alertMessage))
        })
    }
    
}


struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddItem()
                .environmentObject(ItemsEnv())
        }
    }
}
