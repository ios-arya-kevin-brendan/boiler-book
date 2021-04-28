//
//  LoginViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/25/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var visibilityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        emailField.setCorner(radius: emailField.frame.height/2)
        emailField.setBorder(width: 3, color: UIColor.brown)
        emailField.setView(.left, space: 45)
        
        passwordField.setCorner(radius: passwordField.frame.height/2)
        passwordField.setBorder(width: 3, color: UIColor.brown)
        passwordField.setView(.left, space: 45)
        
        loginButton.setCorner(radius: loginButton.frame.height/2)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
        
        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedVisibilityButton(_ sender: Any) {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            visibilityButton.setImage(UIImage(named: "eye"), for: UIControl.State.normal)
        } else {
            passwordField.isSecureTextEntry = true
            visibilityButton.setImage(UIImage(named: "eye.slash"), for: UIControl.State.normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 */
    

}
