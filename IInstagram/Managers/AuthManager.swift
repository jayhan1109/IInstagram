//
//  AuthViewModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit

class LoginManager {
    private var loginModel = LoginFormModel()
    
    func setEmail(with email: String){
        loginModel.email = email
    }
    
    func setPassword(with password: String){
        loginModel.password = password
    }
    
    func getEmail() -> String{
        return loginModel.email ?? ""
    }
    
    func getPassword() -> String{
        return loginModel.password ?? ""
    }
    
    func isFormValid() -> Bool{
        return loginModel.formIsValid
    }
    
    func getBtnBackgroundColor() -> UIColor {
        return loginModel.formIsValid ? .systemBlue : #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    func getBtnTitleColor() -> UIColor{
        return .white
    }
}

class RegisterManager {
    private var registerModel = RegisterFormModel()
    
    func setEmail(with email: String){
        registerModel.email = email
    }
    
    func setPassword(with password: String){
        registerModel.password = password
    }
    
    func setFullname(with fullname: String){
        registerModel.fullname = fullname
    }
    
    func setUsername(with username: String){
        registerModel.username = username
    }
    
    func getEmail() -> String{
        return registerModel.email ?? ""
    }
    
    func getPassword() -> String{
        return registerModel.password ?? ""
    }
    
    func isFormValid() -> Bool{
        return registerModel.formIsValid
    }
    
    func getBtnBackgroundColor() -> UIColor {
        return registerModel.formIsValid ? .systemBlue : #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    func getBtnTitleColor() -> UIColor{
        return .white
    }
}
