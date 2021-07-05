//
//  AuthViewModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit

protocol AuthenticationViewModel {
    func isFormValid() -> Bool
    func getBtnBackgroundColor() -> UIColor
    func getBtnTitleColor() -> UIColor
}

protocol FormViewModel {
    func updateForm()
}

class LoginViewModel: AuthenticationViewModel {
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
        return loginModel.formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    func getBtnTitleColor() -> UIColor{
        return loginModel.formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

class RegisterViewModel: AuthenticationViewModel {
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
        return registerModel.formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    func getBtnTitleColor() -> UIColor{
        return registerModel.formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
