//
//  LoginViewController.swift
//  WaterMyPlants
//
//  Created by Craig Belinfante on 10/14/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //User Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInSignUpSegmentedControl: UISegmentedControl!
    @IBOutlet weak var showHideButton: UIButton!
    
    //Password Strength Outlets
    @IBOutlet weak var weakView: UIView!
    @IBOutlet weak var mediumView: UIView!
    @IBOutlet weak var strongView: UIView!
    @IBOutlet weak var strengthLabel: UILabel!
    
    
    var loginController: LoginController?
    var loginType = LoginType.signUp
    
    //Colors
    private let unusedColor = UIColor.gray
    private let weakColor = UIColor.red
    private let mediumColor = UIColor.yellow
    private let strongColor = UIColor.green
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strengthLabel.text = "Enter a password"
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        passwordTextField.delegate = self
    }
        
    @IBAction func showHideTapped(_ sender: UIButton) {
        
        let toggled = passwordTextField.isSecureTextEntry
        if toggled {
            passwordTextField.isSecureTextEntry.toggle()
            showHideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry.toggle()
            showHideButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func signInTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            signUpButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .signIn
            signUpButton.setTitle("Sign In", for: .normal)
        }
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, !email.isEmpty, let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty {
            let user = UserRepresentation(username: username, password: password, email: email)
            
            switch loginType {
            case .signUp:
                loginController?.signUp(with: user, completion: { (result) in
                    do {
                        let success = try result.get()
                        if success {
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Sign Up Successful", message: "Please log in", preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                                alertController.addAction(alertAction)
                                self.present(alertController, animated: true) {
                                    self.loginType = .signIn
                                    self.signInSignUpSegmentedControl.selectedSegmentIndex = 1
                                    self.signUpButton.setTitle("Sign In", for: .normal)
                                }
                            }
                        }
                    } catch {
                        print("Error \(error)")
                    }
                })
               // weakView.backgroundColor =
                // mediumView.backgroundColor =
                // strongView.backgroundColor =
                strengthLabel.text = ""
            case .signIn:
                    
                loginController?.signIn(with: user, completion: { (result) in
                    do {
                        let success = try result.get()
                        if success {
                            DispatchQueue.main.async {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    } catch {
                        if let error = error as? LoginController.NetworkError {
                            switch error {
                            case .noData, .noToken:
                                print("No data")
                            default:
                                print("Other Error")
                            }
                        }
                        
                    }
                })
            }
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let oldText = passwordTextField.text!
            let stringRange = Range(range, in: oldText)!
            let newText = oldText.replacingCharacters(in: stringRange, with: string)
            updatePassword(newText)
            return true
        }
}



extension LoginViewController {
    
    private func updatePassword(_ password: String) {
        
        if password.count < 8 {
            strengthLabel.text = "Too Weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            animateWeakColorLabel()
        } else if password.count < 12 {
            strengthLabel.text = "Average"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            animateMediumColorLabel()
        } else if password.count >= 12 {
            strengthLabel.text = "Strong"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            animateStrongColorLabel()
        }
    }
    
    @objc private func animateWeakColorLabel() {
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.weakView.center = self.weakView.center
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.weakView.transform = CGAffineTransform(scaleX: 2.7, y: 0.6)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.weakView.transform = CGAffineTransform(scaleX: 0.6, y: 2.7)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.weakView.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.weakView.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animBlock, completion: nil)
    }
    
    @objc private func animateMediumColorLabel() {
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.weakView.center = self.weakView.center
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.mediumView.transform = CGAffineTransform(scaleX: 2.7, y: 0.6)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.mediumView.transform = CGAffineTransform(scaleX: 0.6, y: 2.7)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.mediumView.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.mediumView.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animBlock, completion: nil)
    }
    
    @objc private func animateStrongColorLabel() {
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.weakView.center = self.weakView.center
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.strongView.transform = CGAffineTransform(scaleX: 2.7, y: 0.6)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.strongView.transform = CGAffineTransform(scaleX: 0.6, y: 2.7)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.strongView.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.strongView.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animBlock, completion: nil)
    }
}
