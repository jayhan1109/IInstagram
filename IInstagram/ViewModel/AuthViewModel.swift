//
//  AuthViewModel.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit

class LoginViewModel {
    private var loginModel = LoginFormModel()
    
    func setEmail(with email: String){
        loginModel.email = email
    }
    
    func setPassword(with password: String){
        loginModel.password = password
    }
    
    func getEmail() -> String{
        return loginModel.email
    }
    
    func getPassword() -> String{
        return loginModel.password
    }
    
    func getFormIsValid() -> Bool{
        return loginModel.formIsValid
    }
    
    func getLoginBtnBackgroundColor() -> UIColor {
        return loginModel.formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    func getBtnTitleColor() -> UIColor{
        return loginModel.formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

class RegisterViewModel{
    
}
