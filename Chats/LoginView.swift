//
//  ContentView.swift
//  Chats
//
//  Created by DDUKK7 on 10/11/22.
//

import SwiftUI

struct LoginView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode,
                           label: Text("Picker here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    if !isLoginMode{
                        Button{}
                    label:{
                        Image(systemName: "person.fill").font(.system(size:64)).padding()
                    }
                        
                    }
                    
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button{
                        handleAction()
                    } label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account").foregroundColor(Color.white).padding(.vertical,16).font(.system(size: 14,weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                    Text("Creation Account Page")
                }.padding()
                
                
            }
            .background(Color(.init(white: 0 ,alpha:0.05)).ignoresSafeArea())
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
        }
    }
    private func handleAction(){
        if isLoginMode{
            print("Should Login to Firebase with Existing Credentials")
        }
        else{
            print("Register a new Account with firebase..")
        }
    }
}

struct ContentView_Previews1 : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
