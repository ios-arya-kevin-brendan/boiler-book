//
//  ProfileViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/24/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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