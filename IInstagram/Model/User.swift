//
//  User.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation
import FirebaseAuth

struct User{
    let email: String
    let fullname: String
    let username: String
    let profileImageUrl: String
    let uid: String
    
    var isFollowed: Bool = false
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == self.uid
    }
    
    var imageUrl : URL? {
        return URL(string: profileImageUrl)
    }
}
