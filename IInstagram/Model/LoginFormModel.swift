//
//  LoginFormModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import Foundation

struct LoginFormModel {
    var email: String = ""
    var password: String = ""
    
    var formIsValid: Bool{
        return email.isEmpty == false && password.isEmpty == false
    }
}
