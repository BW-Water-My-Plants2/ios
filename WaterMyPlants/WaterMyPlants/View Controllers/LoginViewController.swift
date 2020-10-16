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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInSignUpSegmentedControl: UISegmentedControl!
    
    var loginController: LoginController?
    var loginType = LoginType.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                                let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
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
}
