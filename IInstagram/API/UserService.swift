//
//  UserService.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping (User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            let data = snapshot?.data()
            
            guard let email = data?["email"] as? String,
                  let fullname = data?["fullname"] as? String,
                  let username = data?["username"] as? String,
                  let profileImageUrl = data?["profileImageUrl"] as? String else { return }
            
            let user = User(email: email, fullname: fullname, username: username, profileImageUrl: profileImageUrl, uid: uid)
            
            completion(user)
        }
    }
}
