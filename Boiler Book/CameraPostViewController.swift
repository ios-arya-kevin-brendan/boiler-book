//
//  CameraPostViewController.swift
//  Boiler Book
//
//  Created by Brendan Lee on 4/11/21.
//

import UIKit

class CameraPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change look of Textfields
        bookTitleTextField.setCorner(radius: bookTitleTextField.frame.height/2)
        bookTitleTextField.setBorder(width: 3, color: UIColor.brown)
        
        authorTextField.setCorner(radius: authorTextField.frame.height/2)
        authorTextField.setBorder(width: 3, color: UIColor.brown)
        
        descriptionTextField.setCorner(radius: descriptionTextField.frame.height/8)
        descriptionTextField.setBorder(width: 3, color: UIColor.brown)
    }

    @IBAction func onPost(_ sender: Any) {
        print("hello")
    }
    
    @IBAction func onTap(_ sender: Any) {
        print("Tapp")
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // Check if Camera is Avaiable
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
}
