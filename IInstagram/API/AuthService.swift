//
//  AuthService.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService{
    
    // Register user with given AuthCredentials
    static func registerUser(credential: AuthCredentials, completion: @escaping(Error?) -> Void){
        
        // Upload Image and create User data in DB
        ImageUploader.uploadImage(image: credential.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                
                if let error = error {
                    completion(error)
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String:Any] = ["email":credential.email,
                                          "fullname":credential.fullname,
                                          "profileImageUrl":imageURL,
                                          "uid":uid,
                                          "username":credential.username]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
    
    // Login user with email and password
    static func loginUser(email: String, password: String, completion: AuthDataResultCallback?){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
