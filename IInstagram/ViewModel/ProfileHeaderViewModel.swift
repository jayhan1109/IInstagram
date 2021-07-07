//
//  ProfileHeaderViewModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation

class ProfileHeaderViewModel {
    let user : User
    
    init(user: User) {
        self.user = user
    }
    
    func getFullname() -> String{
        return user.fullname
    }
    
    func getProfileImageUrl() -> URL? {
        return URL(string: user.profileImageUrl)
    }
}
