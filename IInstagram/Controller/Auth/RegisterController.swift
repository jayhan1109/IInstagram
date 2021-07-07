//
//  RegisterController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-04.
//

import UIKit


class RegisterController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegisterViewModel()
    
    private var profileImage: UIImage?
    
    weak var delegate: AuthDelegate?
    
    private lazy var plusPhotoButton: UIButton = {
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
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(view: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
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
    
    // MARK: - Actions
    
    @objc func handlerShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.setEmail(with: sender.text ?? "")
        } else if sender == passwordTextField{
            viewModel.setPassword(with: sender.text ?? "")
        } else if sender == fullnameTextField{
            viewModel.setFullname(with: sender.text ?? "")
        } else{
            viewModel.setUsername(with: sender.text ?? "")
        }
        
        updateForm()
    }
    
    @objc func handlerProfilePhotoSelect(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handlerRegister(){
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text?.lowercased(),
              let username = usernameTextField.text?.lowercased(),
              let profileImage = profileImage else {return}
        
        let credential = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.registerUser(credential: credential) { error in
            guard error == nil else { return }
            
            self.delegate?.authComplete()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - FormViewModel

extension RegisterController : FormViewModel {
    func updateForm() {
        registerButton.backgroundColor = viewModel.getBtnBackgroundColor()
        registerButton.setTitleColor(viewModel.getBtnTitleColor(), for: .normal)
        registerButton.isEnabled = viewModel.isFormValid()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegisterController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterController: UITextFieldDelegate{
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

