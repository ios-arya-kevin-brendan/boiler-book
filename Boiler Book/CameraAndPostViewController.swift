//
//  CameraAndPostViewController.swift
//  Boiler Book
//
//  Created by Brendan Lee on 4/19/21.
//

import UIKit
import Alamofire
import AlamofireImage
import Parse

class CameraAndPostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var subjectTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        bookTitleTextField.setCorner(radius: bookTitleTextField.frame.height/2)
        bookTitleTextField.setBorder(width: 3, color: UIColor.brown)
        
        authorTextField.setCorner(radius: authorTextField.frame.height/2)
        authorTextField.setBorder(width: 3, color: UIColor.brown)
        
        priceTextField.setCorner(radius: priceTextField.frame.height/2)
        priceTextField.setBorder(width: 3, color: UIColor.brown)
        
        
        subjectTextField.setCorner(radius: subjectTextField.frame.height/2)
        subjectTextField.setBorder(width: 3, color: UIColor.brown)
        
        
        descriptionTextField.setCorner(radius: descriptionTextField.frame.height/8)
        descriptionTextField.setBorder(width: 3, color: UIColor.brown)
    }
    
    @IBAction func onPost(_ sender: Any) {
        print("Post Button")
        let post = PFObject(className: "userPost")
        post["poster"] = PFUser.current()!
        post["bookName"] = bookTitleTextField.text!
        post["author"] = authorTextField.text!
        post["desription"] = descriptionTextField.text!
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "postImage.png", data: imageData!)
        post["image"] = file
        post["subject"] = subjectTextField.text!
        post["price"] = priceTextField.text!
        post["posterUsername"] = PFUser.current()?.username
        
        // Generate unique id
        let randint = (Int.random(in: 9..<12))
        post["uniqueID"] = randomString(length: randint)
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            }
            else {
                print("Error")
            }
        }
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        print("Picture Tap")
        
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
    
    // Called when an image gets picked by user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to:size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
}
