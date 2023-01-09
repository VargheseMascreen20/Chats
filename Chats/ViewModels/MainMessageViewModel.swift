//
//  MainMessageViewModel.swift
//  Chats
//
//  Created by VARGHESE T MASCREEN on 02/01/23.
//

import Foundation
class MainMessageViewModel: ObservableObject{
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    init(){
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut =  FirebaseManager.shared.auth.currentUser?.uid == nil     }
        fetchCurrentUser()
    }
    
 
    
    func fetchCurrentUser(){
        guard let uid =
                FirebaseManager.shared.auth.currentUser?.uid else{
            self.errorMessage = "Could not find Firebase UID"
            return
            
        }
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument{ snapshot, error in
            if let error = error{
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user: ", error)
                return
            }
            guard let data = snapshot?.data() else {
                self.errorMessage = "No Data Found"
                return}
            
            self.chatUser = .init(data: data)
        }
    }
    
    @Published var isUserCurrentlyLoggedOut = false
    
    func handleSignOut(){
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
