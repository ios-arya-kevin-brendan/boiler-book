//
//  DetailsViewController.swift
//  Boiler Book
//
//  Created by Brendan Lee on 4/19/21.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

class DetailsViewController: UIViewController {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!

    var title_text = ""
    var author_text = ""
    var price_text = ""
    var description_text = ""
    var imageFile: PFFileObject?
    
    var posterUsername: String = "error"

    var posts = [PFObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleLabel.text = title_text
        priceLabel.text = price_text
        authorLabel.text = author_text
        descriptionLabel.text = description_text
        let urlString = imageFile?.url ?? "https://i.imgur.com/mCHMpLT.png"
        let url = URL(string: urlString)!
        bookImageView.af.setImage(withURL: url)
        
        print(posterUsername)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toChat") {
            let chatPage = segue.destination as! MessageViewController
            chatPage.receiver = posterUsername
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
