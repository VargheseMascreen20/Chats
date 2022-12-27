//
//  ContentView.swift
//  Chats
//
//  Created by DDUKK7 on 10/11/22.
//

import SwiftUI
import SwiftUIX


struct LoginView: View {
    
    let didCompleteLoginProcess: () -> ()
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var loginStatusMessage = ""
    @State var shouldShowImagePicker = false
    
    
    
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
                        Button{
                            shouldShowImagePicker.toggle()
                        }
                    label:{
                        
                        VStack{
                            if let image = self.image{
                                
                                Image(uiImage: image).resizable().frame(width: 150 , height: 150).scaledToFill().cornerRadius(150)
                               
                            }else{
                                let x = print("NO iMAGE.......")
                                Image(systemName: "person.fill").font(.system(size:64)).padding().foregroundColor(Color(.black))
                            }
                        }.overlay(RoundedRectangle(cornerRadius: 150).stroke(Color.black,lineWidth: 3))
                        
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
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            
        }
    }
    @State var image = UIImage()
    
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
             
            self.didCompleteLoginProcess()
        }
    }
    private func createNewAccount(){
        
        if self.image == nil {
            self.loginStatusMessage = "Please select an avatar image"
            return
        }
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err{
                print("Failed to create user",err)
                self.loginStatusMessage  = "Failed to create user \(err)"
                return
            }
            print("Successfully created user : \(result?.user.uid ?? "")")
            self.loginStatusMessage  = "Successfully created user : \(result?.user.uid ?? "")"
            persistImageToStorage()
        }
    }
    private func persistImageToStorage(){
//        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid )
        guard let imageData = self.image.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData,metadata: nil){ metadata ,err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to storage: \(err)"
                return
            }
            
            ref.downloadURL{ url,err in
                if let err = err{
                    self.loginStatusMessage = "Failed to retrieve downurl: \(err)"
                    return
                }
                self.loginStatusMessage = "Successfulyy stored image with url: \(url?.absoluteString ?? "")"
                guard let url = url else {return}
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    private func storeUserInformation(imageProfileUrl: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{
            return
        }
        let userData = ["email": self.email,"uid": uid,"profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("/users").document(uid).setData(userData){ err in
            if let err = err{
                print(err)
                self.loginStatusMessage = "\(err)"
                return
            }
            print("Success!")
            self.didCompleteLoginProcess()
        }
    }
    
}

struct ContentView_Previews1 : PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: {})
    }
}




