//
//  LoginViewController.swift
//  ParseChat
//
//  Created by David Tan on 2/22/18.
//  Copyright © 2018 DavidTan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Sign Up Button
    @IBAction func register(_ sender: Any) {
        if ((usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Username and Password Required", message: "Please enter a username or password.", preferredStyle: .alert)
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
        }
        registerUser()
    }
    
    // Login Button
    @IBAction func login(_ sender: Any) {
        loginUser()
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    func loginUser() {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

