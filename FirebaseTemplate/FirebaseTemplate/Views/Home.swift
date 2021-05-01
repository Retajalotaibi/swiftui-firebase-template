//
//  Home.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI
import UserNotifications

struct SignOutButton: View{
    var env: FirebaseEnv
    var body: some View{
        VStack {  Button("Signout") {
            env.signOut()
        }.foregroundColor(.red)
        
        }
    }
}

struct Home: View {
    @EnvironmentObject var env: FirebaseEnv
    let itemsEnvironment = ItemsEnv()
    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("") , content: {
                    NavigationLink("Add a new course", destination: AddItem()
                                    .environmentObject(itemsEnvironment))
                    NavigationLink("List all courses", destination: ListItems()
                                    .environmentObject(itemsEnvironment))
                    NavigationLink("List all courses", destination: ExampleCalendarView(days: getDatess())
                    )
                    Button(action: {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }, label: {
                        Text("alow notification")
                    })
                    
                })
            }
            .navigationTitle("Home")
            .navigationBarItems(trailing: SignOutButton(env: env))
        }.onAppear {
            var course: [Course] = []
            // notifications(env: itemsEnvironment)
            Networking.getListOf(COLLECTION_NAME: "course/\(Networking.getUserId()!)/data") { (items: [Course]) in
                course = items
            }
            print(course)
        }
    }
}


    func getDatess() -> [Date]{
        let arr = ["2021-05-02 21:00:00 +0000", "2021-05-05 21:00:00 +0000", "2021-05-10 21:00:00 +0000"]
        var array: [Date] = []
        for i in arr {
            array.append(i.dateFromString!)
        }
        return array
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(FirebaseEnv())
    }
}


func notifications(env: ItemsEnv)  {
    let classes = env.getAllClasses()
    print(classes)
    let content = UNMutableNotificationContent()
    content.title = "task"
    content.subtitle = "please work"
    content.sound = UNNotificationSound.default
    let time = "2021-05-01 09:19:56+0300".dateFromString!
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month,.hour, .day], from: time)
    // show this notification five seconds from now

    print("❤️",components)
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
   
    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
        print(error)

    })
    // add our notification request
    UNUserNotificationCenter.current().add(request)
}
