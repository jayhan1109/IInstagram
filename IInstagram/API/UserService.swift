//
//  UserService.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping (User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            let data = snapshot?.data()
            
            guard let email = data?["email"] as? String,
                  let fullname = data?["fullname"] as? String,
                  let username = data?["username"] as? String,
                  let profileImageUrl = data?["profileImageUrl"] as? String else { return }
            
            let user = User(email: email, fullname: fullname, username: username, profileImageUrl: profileImageUrl, uid: uid)
            
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let users: [User] = snapshot.documents.compactMap { document in
                let data = document.data()
                
                guard let email = data["email"] as? String,
                      let fullname = data["fullname"] as? String,
                      let username = data["username"] as? String,
                      let profileImageUrl = data["profileImageUrl"] as? String,
                      let uid = data["uid"] as? String else { return nil}
                
                return User(email: email, fullname: fullname, username: username, profileImageUrl: profileImageUrl, uid: uid)
                
            }
            
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping (Error?)-> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:],completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping (Error?)-> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping (UserStats)->Void){
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
                let following = snapshot?.documents.count ?? 0
                
                print("f - \(following)")
                
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
}
