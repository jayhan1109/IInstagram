//
//  FeedController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "FeedCell"

class FeedViewController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.title = "Feed"
    }
    
    // MARK: - Actions
    
    // Action to logout
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let vc = LoginViewController()
                vc.delegate = self.tabBarController as? MainTabViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            print("Fail to Sign Out")
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Width -> same with of the view
        // Height -> width + top padding + profile image + bottom padding of profile image + (image + bottom part)
        let width = view.frame.width
        let height = width + 8 + 40 + 8 + 110
        
        return CGSize(width: width, height: height)
    }
}
