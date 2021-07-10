//
//  LoginViewController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit

protocol AuthDelegate: AnyObject {
    func authComplete()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var loginManager = LoginManager()
    
    weak var delegate: AuthDelegate?
    
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        tf.returnKeyType = .continue
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.isEnabled = false
        btn.setHeight(50)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help signing in")
        return btn
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        btn.addTarget(self, action: #selector(handlerShowSignUp), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFieldsDelegate()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
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

    func configureNotificationObservers(){
        // textFields's editing change event
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        // Dismiss keyboard when touch outside of UIView
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureTextFieldsDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func updateForm() {
        loginButton.backgroundColor = loginManager.getBtnBackgroundColor()
        loginButton.setTitleColor(loginManager.getBtnTitleColor(), for: .normal)
        loginButton.isEnabled = loginManager.isFormValid()
    }
    
    // MARK: - Actions
    @objc func handlerShowSignUp(){
        let vc = RegisterViewController()
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // TextFields editing event
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            loginManager.setEmail(with: sender.text ?? "")
        } else{
            loginManager.setPassword(with: sender.text ?? "")
        }
        
         updateForm()
    }
    
    // Action when login button pressed
    @objc func handleLogin(){
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
              
        AuthService.loginUser(email: email, password: password) { result, error in
            if let error = error {
                print("Error logging in \(error.localizedDescription)")
                return
            }
            
            // Implemented in MainTabViewController
            // Fetch User
            self.delegate?.authComplete()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            handleLogin()
        }
        
        return true
    }
}
