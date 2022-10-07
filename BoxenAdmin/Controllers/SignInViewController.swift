//
//  ViewController.swift
//  LoginDemo
//
//  Created by Simon Elhøj Steinmejer on 18/04/2019.
//  Copyright © 2019 Simon Elhøj Steinmejer. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "doctor"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let signLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN"
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("IN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleState), for: .touchUpInside)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UP", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        button.addTarget(self, action: #selector(handleState), for: .touchUpInside)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let slashLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    let usernameTextField = FloatingTextField(placeholderText: "Email")
    let passwordTextField = FloatingTextField(placeholderText: "Password")
    
    let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ENTER", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        button.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return button
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .gray)
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    fileprivate let activeButtonWidth: CGFloat = 62
    fileprivate let activeButtonHeight: CGFloat = 34
    fileprivate let inactiveButtongWidth: CGFloat = 40
    fileprivate let inactiveButtongHeight: CGFloat = 28
    
    fileprivate var isInSignUpState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        self.usernameTextField.floatingDelegate = self
        self.passwordTextField.floatingDelegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func handleEnter() {
        
        guard let email = usernameTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        
        self.loadingIndicator.startAnimating()
        
        if self.isInSignUpState {
            let user = User()
            user.username = email
            user.email = email
            user.password = password
            user.role = "Patient"

            self.loadingIndicator.startAnimating()

            user.signUpInBackground { completed, error in

                self.loadingIndicator.stopAnimating()

                if let error = error {
                    self.alert(title: error.localizedDescription)
                    return
                }

                self.alert(title: "Tillykke! Du er nu oprettet som bruger", message: "", completion: {

                }, cancellable: false)
            }
        } else {
            PFUser.logInWithUsername(inBackground: email, password: password) { user, error in

                self.loadingIndicator.stopAnimating()

                if let error = error {
                    self.alert(title: error.localizedDescription)
                    return
                }

                self.alert(title: "Du er nu logget ind", message: "", completion: {
                    UIApplication.shared.keyWindow?.rootViewController = SideMenuViewController()
                }, cancellable: false)
            }
        }
    }
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleState() {
        isInSignUpState = isInSignUpState ? false : true
        signInButton.isEnabled = isInSignUpState ? true : false
        signUpButton.isEnabled = isInSignUpState ? false : true
        
        if isInSignUpState {
            signUpInactiveLeadingAnchor?.isActive = false
            signUpInactiveCenterYAnchor?.isActive = false
            signInActiveLeadingAnchor?.isActive = false
            signInActiveCenterYAnchor?.isActive = false
            
            signUpActiveLeadingAnchor?.isActive = true
            signUpActiveCenterYAnchor?.isActive = true
            signInInactiveLeadingAnchor?.isActive = true
            signInInactiveCenterYAnchor?.isActive = true
        } else {
            signUpActiveLeadingAnchor?.isActive = false
            signUpActiveCenterYAnchor?.isActive = false
            signInInactiveLeadingAnchor?.isActive = false
            signInInactiveCenterYAnchor?.isActive = false
            
            signUpInactiveLeadingAnchor?.isActive = true
            signUpInactiveCenterYAnchor?.isActive = true
            signInActiveLeadingAnchor?.isActive = true
            signInActiveCenterYAnchor?.isActive = true
        }
        
//        signUpHeightAnchor?.constant = isInSignUpState ? activeButtonHeight : inactiveButtongHeight
//        signUpWidthAnchor?.constant = isInSignUpState ? activeButtonWidth : inactiveButtongWidth
//        signInHeightAnchor?.constant = isInSignUpState ? inactiveButtongHeight : activeButtonHeight
//        signInWidthAnchor?.constant = isInSignUpState ? inactiveButtongWidth : activeButtonWidth
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.signInButton.setTitleColor(self.isInSignUpState ? .gray : .black, for: .normal)
            self.signUpButton.setTitleColor(self.isInSignUpState ? .black : .gray, for: .normal)
            self.signInButton.titleLabel?.font = UIFont.systemFont(ofSize: self.isInSignUpState ? 21 : 42, weight: .bold)
            self.signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: self.isInSignUpState ? 42 : 21, weight: .bold)
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    var signInActiveLeadingAnchor: NSLayoutConstraint?
    var signInInactiveLeadingAnchor: NSLayoutConstraint?
    var signInActiveCenterYAnchor: NSLayoutConstraint?
    var signInInactiveCenterYAnchor: NSLayoutConstraint?
    var signInHeightAnchor: NSLayoutConstraint?
    var signInWidthAnchor: NSLayoutConstraint?
    
    var signUpActiveLeadingAnchor: NSLayoutConstraint?
    var signUpInactiveLeadingAnchor: NSLayoutConstraint?
    var signUpActiveCenterYAnchor: NSLayoutConstraint?
    var signUpInactiveCenterYAnchor: NSLayoutConstraint?
    var signUpHeightAnchor: NSLayoutConstraint?
    var signUpWidthAnchor: NSLayoutConstraint?
    
    fileprivate func setupViews() {
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        view.addSubview(signLabel)
        signLabel.translatesAutoresizingMaskIntoConstraints = false
        signLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        signLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInActiveCenterYAnchor = signInButton.centerYAnchor.constraint(equalTo: signLabel.centerYAnchor)
        signInInactiveCenterYAnchor = signInButton.centerYAnchor.constraint(equalTo: slashLabel.centerYAnchor, constant: 3)
        signInActiveLeadingAnchor = signInButton.leadingAnchor.constraint(equalTo: signLabel.trailingAnchor, constant: 12)
        signInInactiveLeadingAnchor = signInButton.leadingAnchor.constraint(equalTo: slashLabel.trailingAnchor, constant: 8)
        signInButton.heightAnchor.constraint(equalToConstant: activeButtonHeight).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: activeButtonWidth).isActive = true
        signInActiveCenterYAnchor?.isActive = true
        signInActiveLeadingAnchor?.isActive = true
        
        view.addSubview(slashLabel)
        slashLabel.translatesAutoresizingMaskIntoConstraints = false
        slashLabel.bottomAnchor.constraint(equalTo: signLabel.bottomAnchor, constant: -8).isActive = true
        slashLabel.leadingAnchor.constraint(equalTo: signLabel.trailingAnchor, constant: 68).isActive = true
        
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpInactiveCenterYAnchor = signUpButton.centerYAnchor.constraint(equalTo: slashLabel.centerYAnchor, constant: 3)
        signUpActiveCenterYAnchor = signUpButton.centerYAnchor.constraint(equalTo: signLabel.centerYAnchor)
        signUpInactiveLeadingAnchor = signUpButton.leadingAnchor.constraint(equalTo: slashLabel.trailingAnchor, constant: 8)
        signUpActiveLeadingAnchor = signUpButton.leadingAnchor.constraint(equalTo: signLabel.trailingAnchor, constant: 12)
        signUpButton.heightAnchor.constraint(equalToConstant: activeButtonHeight).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: activeButtonWidth).isActive = true
        signUpInactiveCenterYAnchor?.isActive = true
        signUpInactiveLeadingAnchor?.isActive = true
        
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: signLabel.bottomAnchor, constant: 40).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        enterButton.widthAnchor.constraint(equalToConstant: 95).isActive = true
        
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerYAnchor.constraint(equalTo: self.enterButton.centerYAnchor).isActive = true
        loadingIndicator.trailingAnchor.constraint(equalTo: self.enterButton.leadingAnchor, constant: -8).isActive = true
    }
    
}

extension SignInViewController: FloatingTextFieldDelegate {
    func textFieldIsActive() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.backgroundImageView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        }, completion: nil)
    }
    
    func textFieldIsInactive() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.backgroundImageView.transform = .identity
        }, completion: nil)
    }
}

