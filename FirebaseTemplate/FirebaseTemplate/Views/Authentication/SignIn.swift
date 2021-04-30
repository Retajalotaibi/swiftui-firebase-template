//
//  SignInView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct SignIn: View {
    @State var userCredentials = SignInCredentials(email: "", password: "")
    @EnvironmentObject var env: FirebaseEnv
    @State var alertShown: Bool = false
    @State var alertError: String = ""
    var body: some View {
        VStack(spacing: 15){
            
            TextField("email", text: $userCredentials.email).keyboardType(.emailAddress)
            SecureField("password", text: $userCredentials.password)
            Button("Sign in"){
                env.signIn(user: userCredentials) { (uid) in
                    print("Signed in!")
                } fail: { (error) in
                    alertError = error.debugDescription
                    alertShown = true 
                }
            }.frame(width:300, height: 40).background(Color("waleed")).foregroundColor(.white).clipShape(Capsule())
            NavigationLink("Don't have an account?", destination: SignIn())
        }
        .navigationTitle("Sign in")
        .alert(isPresented: $alertShown, content: {
            Alert(title: Text("Error!"), message: Text(alertError), dismissButton: .cancel())
        })
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
            .environmentObject(FirebaseEnv())
    }
}
