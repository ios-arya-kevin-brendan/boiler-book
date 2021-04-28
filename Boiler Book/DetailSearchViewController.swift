//
//  DetailSearchViewController.swift
//  Boiler Book
//
//  Created by arya sharma on 4/11/21.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

class DetailSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    
    var text:String = ""

    @IBOutlet var tableView: UITableView!
    var classes = [PFObject]()
    
    /*
    var class_: Class? {
        didSet {
            //configureView()
        }
    }
     */
    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "userPost")
        //query.selectKeys(["subject"])
        //query.includeKey("poster")
        
        query.whereKey("subject", contains: text)
        
        query.findObjectsInBackground { (classes, error) in
            if classes != nil {
                self.classes = classes!
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailSearchTableViewCell") as! DetailSearchTableViewCell
        let classest = classes[indexPath.row]
        
        cell.titleBook.text = classest["bookName"] as? String
        
        cell.authorBook.text = classest["author"] as? String
        
        cell.priceBook.text = classest["price"] as? String
        
        let imageFile = classest["image"] as! PFFileObject
        let urlString = imageFile.url ?? "https://i.imgur.com/mCHMpLT.png"
        let url = URL(string: urlString)!
        
        cell.bookImage.af.setImage(withURL: url)
        
        
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "individualPost", sender: indexPath)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "individualPost"{
            print("HI BITCH")
            guard let detailVC = segue.destination as? DetailsViewController else {return }
            
            if let indexpath = tableView.indexPathForSelectedRow {
                
                let selectedRow = indexpath.row // Set to the current row element
                let currpost = classes[selectedRow]
                detailVC.title_text = currpost["bookName"] as! String
                detailVC.author_text = currpost["author"] as! String
                detailVC.price_text = currpost["price"] as! String
                detailVC.description_text = currpost["desription"] as! String
                detailVC.imageFile = currpost["image"] as? PFFileObject
                detailVC.posterUsername = currpost["posterUsername"] as! String
                detailVC.poster = currpost["poster"] as? PFUser
                                
            }
            
            print("completed segue")
        }
        viewWillAppear(true)
        
        
    }
 



}

