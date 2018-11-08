//
//  LoginViewController.swift
//  ARBombSquad
//
//  Created by Neil Shah on 11/6/18.
//  Copyright © 2018 starksky. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        if (usernameTextField.text?.isEmpty)! {
            self.createAlert(title: "Sign up failed", message: "Please enter a username.")
        }
        
        if (passwordTextField.text?.isEmpty)! {
            self.createAlert(title: "Sign up failed", message: "Please enter a password.")
        }
        
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("User Created")
                self.createAlert(title: "Signup Successful", message: "Account created.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription as Any)
                if error?._code==202 {
                    self.createAlert(title: "Sign up failed", message: "User already exists.")
                }
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if (usernameTextField.text?.isEmpty)! {
            self.createAlert(title: "Login failed", message: "Please enter a username.")
        }
        
        if (passwordTextField.text?.isEmpty)! {
            self.createAlert(title: "Login failed", message: "Please enter a password.")
        }
        
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?,error: Error?) in
            if user != nil {
                print("Yay, you're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription as Any)
                self.createAlert(title: "Login Failed", message: "User does not exist.")
            }
        }
    }
    
    func createAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) {(action) in}
        alertController.addAction((dismissAction))
        self.present(alertController, animated: true) {
        }
    }
}
