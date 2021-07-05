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
    static func registerUser(credential: AuthCredentials, completion: @escaping(Error?) -> Void){
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
                
                Firestore.firestore().collection("users").document(uid).setData(data) { error in
                    completion(error)
                }
            }
        }
    }
}
