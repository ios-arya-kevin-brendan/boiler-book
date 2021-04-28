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
    
    /*
     How to sent post data with segue:
     1. the function tableView(didSelectRowAt: indexpth) will send perform segue and call the prepare funciton
     2. the prepare function will open the detailViewController and send information to the temp variables in DetailsViewController
     3. call viewWillAppear() to clear the selection
     */
    
    // Trigger Segue when tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailBook", sender: indexPath.row);
    }
    
    // Clear selection
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Depends on the name of the segue identifier
        if segue.identifier == "detailBook"  {
            // Open detailVC to access the DetailsViewController
            guard let detailVC = segue.destination as? DetailsViewController else { return }
            // Get current row
            if let selectedRow = sender as? Int {// Set to the current row element
                let currpost = posts[selectedRow]
                detailVC.title_text = currpost["bookName"] as! String
                detailVC.author_text = currpost["author"] as! String
                detailVC.price_text = currpost["price"] as! String
                detailVC.description_text = currpost["desription"] as! String
                detailVC.imageFile = currpost["image"] as? PFFileObject
                detailVC.posterUsername = currpost["posterUsername"] as! String
                detailVC.poster = currpost["poster"] as! PFUser
            }
            print("completed segue")
        }
        // Clear selection
        viewWillAppear(true)
    }
}
