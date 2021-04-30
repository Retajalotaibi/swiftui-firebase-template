//
//  SignInView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    @State var user = User()
    @State var password = ""
    @EnvironmentObject var env: FirebaseEnv
    var body: some View {
  
        VStack (spacing: 20){
           
            VStack {
                TextField("first name", text: $user.firstName).keyboardType(.default).padding(.bottom, 20)
                TextField("last name", text: $user.lastName).keyboardType(.default).padding(.bottom, 20)
                TextField("email", text: $user.email).keyboardType(.emailAddress).padding(.bottom, 20)
                SecureField("password", text: $password).padding(.bottom, 20)
            }.padding()

            Button("Sign up"){
                env.signUp(user: user, password: password)
            }.frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
            Spacer()
        }.padding().padding(.top, 40)
        .navigationTitle("Sign up")
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SignUp()
                .environmentObject(FirebaseEnv())
        }
    }
}
