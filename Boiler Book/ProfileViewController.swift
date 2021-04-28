//
//  ProfileViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/24/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var nameField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()!
        let rawImageFile = user["profilePicture"]
        if rawImageFile != nil {
            let imageFile = rawImageFile as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
        
            profileImage.af.setImage(withURL: url)
        }
        nameField.text = user["name"] as? String
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let user = PFUser.current()!
        let rawImageFile = user["profilePicture"]
        if rawImageFile != nil {
            let imageFile = rawImageFile as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
        
            profileImage.af.setImage(withURL: url)
        }
        nameField.text = user["name"] as? String
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
    }
    
    @IBAction func onSettingsClick(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: nil)
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
