//
//  ProfileViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 3/24/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
//    var myPosts: [PFObject] = [PFObject]()
//
//    @IBOutlet weak var postTableView: UITableView!
//
//
//    func populatePosts() {
//        let query = PFQuery(className:"userPost")
//        print("butt")
//        query.whereKey("posterUsername", contains: PFUser.current()?.username)
//        print("stupid")
//        query.findObjectsInBackground { (posts, error) in
//            self.myPosts = posts!
//            print(self.myPosts)
//            self.postTableView.reloadData()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myPosts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("gets here")
//        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostsCell") as! ProfilePostCell
//
//        let post = myPosts[indexPath.row]
//
//        cell.titleLabel.text = post["bookName"] as? String
//        cell.authorLabel.text = post["author"] as? String
//        cell.priceLabel.text = "$" + ((post["price"] as? String)!)
//        cell.descriptionLabel.text = post["description"] as? String
//
//        let rawImageFile = post["image"]
//        let imageFile = rawImageFile as! PFFileObject
//        let urlString = imageFile.url ?? "https://i.imgur.com/mCHMpLT.png"
//        let url = URL(string: urlString)!
//
//        cell.postPicture.af.setImage(withURL: url)
//        return cell
//    }
//

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var nameField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.postTableView.dataSource = self
//        self.postTableView.delegate = self

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
//        populatePosts()

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
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        
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
