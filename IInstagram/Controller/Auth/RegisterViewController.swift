//
//  RegisterController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit


class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    private var registerManager = RegisterManager()
    
    private var profileImage: UIImage?
    
    weak var delegate: AuthDelegate?
    
    private lazy var profileImageView: UIButton = {
        let btn = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .regular, scale: .large)
        btn.setImage(UIImage(systemName: "person.circle", withConfiguration: largeConfig), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handlerProfilePhotoSelect), for: .touchUpInside)
        return btn
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
        tf.returnKeyType = .continue
        return tf
    }()
    
    private let fullnameTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Fullname")
        tf.returnKeyType = .continue
        return tf
    }()
    
    private let usernameTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Username")
        tf.returnKeyType = .continue
        return tf
    }()
    
    private lazy var registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.setHeight(50)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handlerRegister), for: .touchUpInside)
        return btn
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Already have an account? ", secondPart: "Log In")
        btn.addTarget(self, action: #selector(handlerShowLogin), for: .touchUpInside)
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
        
        view.addSubview(profileImageView)
        profileImageView.centerX(view: view)
        profileImageView.setDimensions(height: 140, width: 140)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(view: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureTextFieldsDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fullnameTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    // Update form everytime the text fields are edited
    func updateForm() {
        registerButton.backgroundColor = registerManager.getBtnBackgroundColor()
        registerButton.setTitleColor(registerManager.getBtnTitleColor(), for: .normal)
        registerButton.isEnabled = registerManager.isFormValid()
    }
    
    // MARK: - Actions
    
    // Action going back to LoginViewController
    @objc func handlerShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    // TextFields editing event
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            registerManager.setEmail(with: sender.text ?? "")
        } else if sender == passwordTextField{
            registerManager.setPassword(with: sender.text ?? "")
        } else if sender == fullnameTextField{
            registerManager.setFullname(with: sender.text ?? "")
        } else{
            registerManager.setUsername(with: sender.text ?? "")
        }
        
        updateForm()
    }
    
    // Action when profile image button pressed
    @objc func handlerProfilePhotoSelect(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    // Action when register button pressed
    @objc func handlerRegister(){
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text?.lowercased(),
              let username = usernameTextField.text?.lowercased(),
              let profileImage = profileImage else {return}
        
        let credential = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.registerUser(credential: credential) { error in
            guard error == nil else { return }
            
            // Implemented in MainTabViewController
            // Fetch User
            self.delegate?.authComplete()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Parse image from image picker and set it to plusPhotoButton
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        
        profileImage = selectedImage
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            fullnameTextField.becomeFirstResponder()
        } else if textField == usernameTextField {
            handlerRegister()
        }
        
        return true
    }
}

