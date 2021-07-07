//
//  ProfileHeaderModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation

struct ProfileHeaderModel {
    let user : User
    
    init(user: User) {
        self.user = user
    }
    
    var fullname: String {
        user.fullname
    }
    
    var profileImageUrl: URL? {
        URL(string: user.profileImageUrl)
    }
}
