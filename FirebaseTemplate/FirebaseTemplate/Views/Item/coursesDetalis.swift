//
//  coursesDetalis.swift
//  FirebaseTemplate
//
//  Created by Retaj Al-Otaibi on 30/04/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//

let dd = [Classes(id: "", name: "math", color: "Red", dates: ["sat", "monday"], time: ["4","5"])]
import SwiftUI
let colors = ["Red", "Blue", "Green", "Purple", "Orange"]
struct coursesDetalis: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    @State var currentCorses: Course
    var body: some View {
        
        VStack{
            List(itemsEnv.classes, id: \.self) { currentClass in
                NavigationLink(
                    destination: tasksView(currentClass: currentClass, currentcourseName: "\(currentCorses.id)").environmentObject(ItemsEnv()),
                    label: {
                        VStack {
                            HStack {
                                HStack {
                                    Text("     ").background(getColor(currentClass: currentClass)).clipShape(Capsule())
                                    Text(currentClass.name).fontWeight(.bold)
                                }
                                Spacer()
                                Text(currentClass.dates[0])
                                Text(currentClass.dates[1])
                            }
                          
                        }
                    })
                
            }
            
            NavigationLink(destination: addClass(currentCorses: self.currentCorses).environmentObject(self.itemsEnv),
                           label:
                            {
                                Text("Go to add a class").frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
                                
                            })

            
        }.onAppear{ itemsEnv.loadClass(courseName: "\(currentCorses.id)")}
//        (perform: )
    }
}

struct coursesDetalis_Previews: PreviewProvider {
    static var previews: some View {
        coursesDetalis( currentCorses: Course(id: "", name: "", startDay: "", endDay: ""))
    }
}


func getColor(currentClass: Classes) -> Color{
    switch currentClass.color {
    case "0": return Color(.red)
    case "1": return Color(.blue)
    case "2": return Color(.green)
    case "3": return Color(.purple)
    case "4": return Color(.orange)
    default:
         return Color(.white)
    }
}

struct addClass: View {
    @EnvironmentObject var env: FirebaseEnv
    @State var className: String = ""
    @State var id: String = ""
    @State var classTime: String = ""
    @State var colorIndex: Int = 0
    @State var manyDays = [Date]()
    @State var showSheet: Bool = false
    @State var currentCorses: Course
    @State var startClass = Date()
    @State var endClass = Date()
    @EnvironmentObject var itemsEnv: ItemsEnv
    var body: some View {
        VStack {
            MultiDatePicker(anyDays: self.$manyDays)
            Form {
                Section(footer: Text("") , content: {
                    TextField("class name", text: $className)
                    TextField("id", text: $id)
                    HStack {
                        DatePicker("", selection: $startClass, displayedComponents: .hourAndMinute)
                        Text("     to")
                        DatePicker("", selection: $endClass, displayedComponents: .hourAndMinute)
                    }
                    Picker("Color", selection:  $colorIndex, content: { // <2>
                        Text("Red").tag(0) // <3>
                        Text("Blue").tag(1) // <4>
                        Text("Green").tag(2) // <5>
                        Text("Purple").tag(3) // <3>
                        Text("Orange").tag(4) // <4>
                    })
                })
            }
            
            Button("submit"){
                self.showSheet = false
                print("\(className) , \(classTime), \(colorIndex) , \(manyDays)")
                let formatedArrayOfdates = formatTheArray(array: manyDays)
               
                 let formatedSH = hourFormatter.string(from: startClass)
                let formatedEH = hourFormatter.string(from: endClass)
                let data = Classes(id: id, name: className, color: String(colorIndex), dates:formatedArrayOfdates , time: [formatedSH ,formatedEH])
                print(currentCorses.id)
                itemsEnv.addClass(userClass: data, courseName: "\(currentCorses.id)")
            }.frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
        
        }
    }
}

func formatTheArray(array: [Date]) -> [String] {
    var returnedArray: [String] = []
    for element in array {
        returnedArray.append(dateFormatterf.string(from: element))
        
    }
      return returnedArray
}
var dateFormatterf: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}
var hourFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
    return formatter
}
