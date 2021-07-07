//
//  ImageUploader.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let image = image.jpegData(compressionQuality: 0.75) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(image, metadata: nil) { (metadata, error) in
          guard error == nil else {
            // Uh-oh, an error occurred!
            return
          }
            
          ref.downloadURL { (url, error) in
            guard let url = url?.absoluteString else { return }
            completion(url)
          }
        }
    }
}
