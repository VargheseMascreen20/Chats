//
//  ContentView.swift
//  Chats
//
//  Created by DDUKK7 on 10/11/22.
//

import SwiftUI

struct ContentView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Picker(selection: $isLoginMode,
                           label: Text("Picker here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    Button{}
                label:{
                    Image(systemName: "person.fill").font(.system(size:64)).padding()
                }
                    TextField("Email", text: $email)
                    TextField("Password", text: $password)
                    Button{} label: {
                        HStack{
                            Spacer()
                            Text("Create Account").foregroundColor(Color.white).padding(.vertical,16)
                            Spacer()
                        }.background(Color.blue)
                    }
                    Text("Creation Account Page")
                }.padding()
                
            }.navigationTitle("Create Account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
