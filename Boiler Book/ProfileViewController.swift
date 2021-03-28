//
//  ProfileViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/24/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var yourName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()!
        
        yourName.text = user["name"] as? String

        // Do any additional setup after loading the view.
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
