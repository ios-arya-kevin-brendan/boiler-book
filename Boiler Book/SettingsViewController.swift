//
//  SettingsViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/29/21.
//

import UIKit
import Parse
import AlamofireImage

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var changedProfilePicture: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changedProfilePicture = false
        let user = PFUser.current()!
        let rawImageFile = user["profilePicture"]
        
        displayName.placeholder = user["name"] as? String
        if rawImageFile != nil {
            let imageFile = rawImageFile as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
        
            profileImage.af.setImage(withURL: url)
        }
        
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        let user = PFUser.current()!
        
        if displayName.text != "" || displayName.text != nil {
            user["name"] = displayName.text
        }
        
        if changedProfilePicture {
            let imageData = profileImage.image!.pngData()
            let file = PFFileObject(data: imageData!)
        
            user["profilePicture"] = file
        
            user.saveInBackground { (success, error) in
                self.goBack(self)
                if success {
                    print("saved profile picture!")
                } else {
                    print("error!")
                }
            }
        }
        
    }
    
    
    @IBAction func onImageTap(_ sender: Any) {
        print("choosing new image")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 181, height: 181)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        changedProfilePicture = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        performSegue(withIdentifier: "LogoutSegue", sender: nil)
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
