//
//  MainMessagesView.swift
//  Chats
//
//  Created by VARGHESE T MASCREEN on 26/12/22.
//

import SwiftUI

struct MainMessagesView: View {
    @State var shouldShowLogOutOptions = false
    private var customNavBar: some View {
        HStack(spacing:16){
            
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4){
                Text("USERNAME")
                    .font(.system(size: 24.0,weight: .bold))
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("Online")
                        .font(.system(size: 12.0))
                        .foregroundColor(Color(.lightGray))
                }
                
            }
            Spacer()
            Button{
                shouldShowLogOutOptions.toggle()
            }label: {
                Image(systemName: "gear")
                    .font(.system(size:24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }.padding()
            .actionSheet(isPresented: $shouldShowLogOutOptions){
                .init(title: Text("Settings"),message: Text("What do you want to do?"), buttons: [
//                            .default(Text("DEFAULT BUTTON")),
                    .destructive(Text("Sign Out"),action: {
                        print("Handle Sign Out")
                    }),
                    .cancel()
                ])
            }

    }
    var body: some View {
        NavigationView{
            VStack {
                
                customNavBar
                messagesView

                
            }
            .overlay(
                newMessageButton,alignment: .bottom)
            .navigationBarHidden(true)
            
        }
    }
    private var messagesView: some View{
        ScrollView{
            ForEach(0..<10,id: \.self){
                num in
                VStack {
                    HStack(spacing:16){
                        Image(systemName: "person.fill")
                            .font(.system(size: 34))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label), lineWidth: 1)
                                     
                            )
                        VStack(alignment: .leading){
                            Text("Username")
                                .font(.system(size: 16,weight: .bold))
                            Text("Message Sent to user")
                                .font(.system(size: 14.0))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()
                        Text("22nd")
                            .font(.system(size: 14,weight: .semibold))
                    }
                    Divider().padding(.vertical,8)
                    
                }.padding(.horizontal)
            }.padding(.bottom, 50)
            
        }
    }
    private var newMessageButton: some View{
        Button{
            
        }
        label:{
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
                
            }
            .foregroundColor(Color.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 5)
            
            
        }
    }
    
    struct MainMessagesView_Previews: PreviewProvider {
        static var previews: some View {
            MainMessagesView()
                .preferredColorScheme(.dark)
            MainMessagesView()
        }
    }
}
