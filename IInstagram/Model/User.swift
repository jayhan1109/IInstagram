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
    
    var stats: UserStats = UserStats(followers: 0, following: 0)
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == self.uid
    }
    
    var imageUrl : URL? {
        return URL(string: profileImageUrl)
    }
}

struct UserStats {
    let followers: Int
    let following: Int
}
