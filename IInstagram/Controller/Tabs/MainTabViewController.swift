//
//  ViewController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit
import FirebaseAuth

class MainTabViewController: UITabBarController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            // Configure view controllers when user is set
            guard let user = user else { return }
            configureViewControllers(with: user)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUserIsLoggedIn()
        fetchUser()
    }
    
    // MARK: - API
    
    // Check if user is logged in and if not, go to login page
    func checkUserIsLoggedIn(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let vc = LoginViewController()
                vc.delegate = self
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    // Fetch user from API and initialize user property
    func fetchUser(){
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    
    // MARK: - Helpers
    
    private func configureViewControllers(with user: User){
        view.backgroundColor = .white
        
        let feedLayout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedViewController(collectionViewLayout: feedLayout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchViewController())
        
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorViewController())
        
        let notification = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationViewController())
        
        let profileVC = ProfileViewController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileVC)
        
        viewControllers = [feed, search, imageSelector, notification, profile]
        
        tabBar.tintColor = .black
    }
    
    // Create a tab of UINavigationController from UIViewController
    private func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
    }
}

// MARK: - AuthDelegate

extension MainTabViewController: AuthDelegate{
    
    // Fetch user when authentication is completed
    func authComplete() {
        fetchUser()
    }
}
