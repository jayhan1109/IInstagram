//
//  User.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation

struct User{
    let email: String
    let fullname: String
    let username: String
    let profileImageUrl: String
    let uid: String
    
    var imageUrl : URL? {
        return URL(string: profileImageUrl)
    }
}
