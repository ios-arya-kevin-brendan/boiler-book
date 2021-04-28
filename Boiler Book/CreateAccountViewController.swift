//
//  LoginViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/24/21.
//

import UIKit
import Parse

class CreateAccountController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var visibilityButton: UIButton!
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //setting up textbox/buttons
        emailField.setCorner(radius: emailField.frame.height/2)
        emailField.setBorder(width: 3, color: UIColor.brown)
        emailField.setView(.left, space: 45)
        
        nameField.setCorner(radius: nameField.frame.height/2)
        nameField.setBorder(width: 3, color: UIColor.brown)
        nameField.setView(.left, space: 45)
        
        passwordField.setCorner(radius: passwordField.frame.height/2)
        passwordField.setBorder(width: 3, color: UIColor.brown)
        passwordField.setView(.left, space: 45)
        
        createAccountButton.setCorner(radius: createAccountButton.frame.height/2)
        
        googleButton.setBorder(width: 2, color: UIColor.black)
        googleButton.setCorner(radius:  30)
        
        appleButton.setBorder(width: 2, color: UIColor.black)
        appleButton.setCorner(radius: 30)
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
    
    @IBAction func createAccount(_ sender: Any) {
        
        
        if !emailField.hasText || !nameField.hasText || !passwordField.hasText {
            return
        }
        
        let user = PFUser()
        
        user.email = emailField.text
        user.username = emailField.text
        user.password = passwordField.text
        user["name"] = nameField.text
        
        user.signUpInBackground { (success, error) in
            if success {
//                user["name"] = self.nameField.text
                self.performSegue(withIdentifier: "createdAccount", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        //eventually
    }
    
    @IBAction func appleSignIn(_ sender: Any) {
        //eventually
    }
    @IBAction func goToLoginScreen(_ sender: Any) {
        performSegue(withIdentifier: "loggingIn", sender: nil)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func setCorner(radius: CGFloat) {
            layer.cornerRadius = radius
            clipsToBounds = true
        }
    func setBorder(width: CGFloat, color: UIColor) {
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
}

extension UITextField {
    enum ViewType {
        case left, right
    }
    
    // (1)
    func setView(_ type: ViewType, with view: UIView) {
        if type == ViewType.left {
            leftView = view
            leftViewMode = .always
        } else if type == .right {
            rightView = view
            rightViewMode = .always
        }
    }
    
    @discardableResult
    func setView(_ view: ViewType, image: UIImage?, width: CGFloat = 50) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
        button.setImage(image, for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        setView(view, with: button)
        return button
    }
    
    @discardableResult
    func setView(_ view: ViewType, space: CGFloat) -> UIView {
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: 1))
        setView(view, with: spaceView)
        return spaceView
    }
}
