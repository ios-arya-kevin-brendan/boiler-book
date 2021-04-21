//
//  SettingsViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/29/21.
//

import UIKit
import Parse
import AlamofireImage

class SettingsViewController: UIViewController {

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
        
        displayName.text = user.username
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
    }
    
    @IBAction func onImageTap(_ sender: Any) {
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
