//
//  ProfileHeaderModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation
import UIKit

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
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
}
