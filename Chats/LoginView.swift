//
//  ContentView.swift
//  Chats
//
//  Created by DDUKK7 on 10/11/22.
//

import SwiftUI
import Firebase
class FirebaseManager: NSObject{
    let auth: Auth
    static let shared = FirebaseManager()
    override init(){
        
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
   

}
struct LoginView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var loginStatusMessage = ""
    
//    init(){
//        FirebaseApp.configure()
//    }
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
                    Text(self.loginStatusMessage).foregroundColor(.red)
                }.padding()
                
                
            }
            .background(Color(.init(white: 0 ,alpha:0.05)).ignoresSafeArea())
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func handleAction(){
        if isLoginMode{
            loginUser()
            print("Should Login to Firebase with Existing Credentials")
        }
        else{
            createNewAccount()
            print("Register a new Account with firebase..")
        }
    }
    private func loginUser(){
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password){
            result ,err in
            if let err = err{
                print("Failed to login user",err)
                self.loginStatusMessage  = "Failed to login user \(err)"
                return
            }
            print("Successfully logged in user : \(result?.user.uid ?? "")")
            self.loginStatusMessage  = "Successfully logged in user : \(result?.user.uid ?? "")"
        }
    }
    private func createNewAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err{
                print("Failed to create user",err)
                self.loginStatusMessage  = "Failed to create user \(err)"
                return
            }
            print("Successfully created user : \(result?.user.uid ?? "")")
            self.loginStatusMessage  = "Successfully created user : \(result?.user.uid ?? "")"
        }
    }
}

struct ContentView_Previews1 : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
