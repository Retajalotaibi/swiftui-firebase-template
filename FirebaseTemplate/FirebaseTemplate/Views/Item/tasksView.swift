//
//  tasksView.swift
//  FirebaseTemplate
//
//  Created by Retaj Al-Otaibi on 01/05/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//
let taskkss = [Tasks(taskName: "do code", due: "now"), Tasks(taskName: "do code", due: "now"),Tasks(taskName: "do code", due: "now")]
import SwiftUI
var taskDueAtN = ""
struct tasksView: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    @State var currentClass: Classes
    @State var currentcourseName = ""
    @State var showSheet = false
    @State var taskname: String = ""
    
    @State private var taskDue = Date()
    var body: some View {
        VStack{
            List(itemsEnv.tasks, id: \.self) { task in
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        HStack {
                            Text(task.taskName)
                            Spacer()
                            Text(task.due).font(.system(size: 15))
                        }

                    })
            }
            Spacer()
            Button(action: {
                self.showSheet = true
            }, label: {
                Text("Go to add a task").frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
            }).sheet(isPresented: $showSheet, content: {
                Form {
                    Section(footer: Text("") , content: {
                        TextField("Task name", text: $taskname)
                        DatePicker("course start at", selection: $taskDue, displayedComponents: .hourAndMinute)
               
                    })
                    Button(action: {
                        let formatedTask = dateFormatterf.string(from: taskDue)
                        let task = Tasks(taskName: taskname, due: formatedTask)
                        taskDueAtN = "\(taskDue)"
                        itemsEnv.addTask(task: task, userClass: "\(currentClass.id)", courseName: currentcourseName)
                        
                    }, label: {
                        Text("submit").frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
                    })
                }
            })
            
        }.onAppear {
            itemsEnv.loadTask( userClass: "\(currentClass.id)", courseName: currentcourseName)
        }
        
    }
}

struct tasksView_Previews: PreviewProvider {
    static var previews: some View {
        tasksView(currentClass: Classes(id: "", name: "", color: "", dates: ["",""], time: [""]))
    }
}

//struct addTask: View {
//    @State var taskname: String = ""
//    @State private var taskDue: Date = Date()
//    var body: some View {
//        VStack{
//            TextField("Task name", text: $taskname)
//            DatePicker("course start at", selection: $taskDue, displayedComponents: .date)
//        }
//    }
//    //.onAppear{ itemsEnv.loadClass(courseName: currentCorses.name)}
//}

