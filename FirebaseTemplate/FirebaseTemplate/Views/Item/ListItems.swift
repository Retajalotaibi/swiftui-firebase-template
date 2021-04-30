//
//  ListItems.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct ListItems: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    
    var body: some View {
        List(itemsEnv.course, id: \.self){ item in
            NavigationLink(
                destination: coursesDetalis(currentCorses: item),
                label: {
                    VStack(alignment: .leading){
                        Text(item.name).fontWeight(.bold)
                        HStack {
                            Text("start at \(item.startDay)")
                            Text("end at \(item.endDay)")
                        }
                    }
                })
            
        }
        .navigationTitle("courses List")
        .onAppear(perform: itemsEnv.loadItems)
    }
    
}

struct ListItems_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListItems()
                .environmentObject(ItemsEnv())
        }
    }
}
