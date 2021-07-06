//
//  ProfileController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
    
    // MARK: - Helpers
    
    func configureCollectionview(){
        collectionView.backgroundColor = .white
    }
}
