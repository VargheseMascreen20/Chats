//
//  FirebaseManager.swift
//  Chats
//
//  Created by VARGHESE T MASCREEN on 26/12/22.
//

import Foundation
import Firebase

class FirebaseManager: NSObject{
    let auth: Auth
    let storage:Storage
    let firestore: Firestore
    static let shared = FirebaseManager()
    override init(){
        
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }
   

}
