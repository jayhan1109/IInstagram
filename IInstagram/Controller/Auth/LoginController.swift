//
//  LoginController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.setHeight(50)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return btn
    }()
    
    private let forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        
        let atts :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        
        let boldAtts :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        
        let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: atts)
       
        attributedTitle.append(NSAttributedString(string: "Get help signing in", attributes: boldAtts))
        
        btn.setAttributedTitle(attributedTitle, for: .normal)
        
        return btn
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        
        let atts :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        
        let boldAtts :[NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: atts)
       
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAtts))
        
        btn.setAttributedTitle(attributedTitle, for: .normal)
        
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        view.addSubview(iconImage)
        iconImage.centerX(view: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32, width: 120, height: 80)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(view: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
