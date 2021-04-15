//
//  PostViewController.swift
//  Boiler Book
//
//  Created by Brendan Lee on 4/11/21.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!  //Posted Image
    @IBOutlet weak var bookTitle: UITextView!
    @IBOutlet weak var descriptionTitle: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func messageButton(_ sender: Any) {
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
