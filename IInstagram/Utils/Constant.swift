//
//  Constant.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-06.
//

import FirebaseFirestore

// MARK: - Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_USER_FOLLOWING = "user-following"
let COLLECTION_USER_FOLLOWER = "user-followers"
