//
//  FeedViewController.swift
//  Boiler Book
//
//  Created by Brendan Lee on 4/19/21.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

//priceTextField.setCorner(radius: priceTextField.frame.height/2)
//priceTextField.setBorder(width: 3, color: UIColor.brown)
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"userPost")
        query.includeKey("poster")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        cell.bookTitleLabel.text = post["bookName"] as? String
        
        cell.priceLabel.text = post["price"] as? String
        cell.posterLabel.text = post["subject"] as? String  //rename the outlet
        cell.authorLabel.text = post["author"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url ?? "https://i.imgur.com/mCHMpLT.png"
        let url = URL(string: urlString)!
        
        cell.bookPhoto.af.setImage(withURL: url)
        
 
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailBook" {
            guard let detailVC = segue.destination as? DetailsViewController else { return }
            
            if let indexpath = tableView.indexPathForSelectedRow {
                
                let selectedRow = indexpath.row // Set to the current row element
                let currpost = posts[selectedRow]
                detailVC.title_text = currpost["bookName"] as! String
                detailVC.author_text = currpost["author"] as! String
                detailVC.price_text = currpost["price"] as! String
                detailVC.description_text = currpost["desription"] as! String
                detailVC.imageFile = currpost["image"] as? PFFileObject
                

                                
            }

            
        }
    }
}
//priceTextField.setCorner(radius: priceTextField.frame.height/2)
//priceTextField.setBorder(width: 3, color: UIColor.brown)
