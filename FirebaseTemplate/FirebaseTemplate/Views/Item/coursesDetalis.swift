//
//  coursesDetalis.swift
//  FirebaseTemplate
//
//  Created by Retaj Al-Otaibi on 30/04/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//

let dd = [Classes(name: "math", color: "Red", dates: ["sat", "monday"], time: "4-5")]
import SwiftUI
let colors = ["Red", "Blue", "Green", "Purple", "Orange"]
struct coursesDetalis: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    @State var currentCorses: Course
    var body: some View {
        
        VStack{
            List(dd, id: \.self) { d in
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        VStack {
                            HStack {
                                HStack {
                                    Text("     ").background(getColor(currentClass: d)).clipShape(Capsule())
                                    Text(d.name).fontWeight(.bold)
                                }
                                Spacer()
                                Text(d.dates[0])
                                Text(d.dates[1])
                            }
                            HStack {
                                Text("       \(d.time)")
                                Spacer()
                            }
                        }
                    })
                
            }
            
            NavigationLink(destination: addClass(currentCorses: self.currentCorses).environmentObject(self.itemsEnv),
                           label:
                            {
                                Text("Go to add a class").frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
                                
                            })
            //            Button("add a class"){
            //                self.showSheet = true
            //            }.frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule()).fullScreenCover(isPresented: $showSheet, content: {
            //                VStack {
            //                    MultiDatePicker(anyDays: self.$manyDays)
            //                    Form {
            //                        Section(footer: Text("") , content: {
            //                            TextField("class name", text: $className)
            //                            TextField("class time", text: $classTime)
            //                            Picker("Color", selection:  $colorIndex, content: { // <2>
            //                                Text("Red").tag(0) // <3>
            //                                Text("Blue").tag(1) // <4>
            //                                Text("Green").tag(2) // <5>
            //                                Text("Purple").tag(3) // <3>
            //                                Text("Orange").tag(4) // <4>
            //                            })
            //                        })
            //                    }
            //
            //                    Button("submit"){
            //                        self.showSheet = false
            //                    }.frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white)
            //
            //
            //                }
            //            })
            
        }
        //        .onAppear(perform: itemsEnv.loadItems)
    }
}

struct coursesDetalis_Previews: PreviewProvider {
    static var previews: some View {
        coursesDetalis( currentCorses: Course(name: "", startDay: "", endDay: ""))
    }
}


func getColor(currentClass: Classes) -> Color{
    switch currentClass.color {
    case "Red": return Color(.red)
    case "Blue": return Color(.blue)
    case "Green": return Color(.green)
    case "Purple": return Color(.purple)
    case "Oxrange": return Color(.orange)
    default:
         return Color(.white)
    }
}

struct addClass: View {
    @EnvironmentObject var env: FirebaseEnv
    @State var className: String = ""
    @State var classTime: String = ""
    @State var colorIndex: Int = 0
    @State var manyDays = [Date]()
    @State var showSheet: Bool = false
    @State var currentCorses: Course
    @EnvironmentObject var itemsEnv: ItemsEnv
    var body: some View {
        VStack {
            MultiDatePicker(anyDays: self.$manyDays)
            Form {
                Section(footer: Text("") , content: {
                    TextField("class name", text: $className)
                    TextField("class time", text: $classTime)
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
                let data = Classes(name: className, color: "\(colorIndex)", dates: ["ss", "ss"], time: classTime)
                itemsEnv.addClass(userClass: data, courseName: currentCorses.name)
            }.frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
        
        }
    }
}
