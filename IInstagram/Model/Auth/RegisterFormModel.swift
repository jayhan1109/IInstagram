//
//  RegisterFormModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import Foundation

struct RegisterFormModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool{
        return
            (email ?? "").isEmpty == false
            && (password ?? "").isEmpty == false
            && (fullname ?? "").isEmpty == false
            && (username ?? "").isEmpty == false
        
    }
}
