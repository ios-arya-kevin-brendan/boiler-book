//
//  MessageOverviewViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/21/21.
//

import UIKit
import Parse

class MessageOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var user = PFUser.current()
    
    @IBOutlet weak var messageOverView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageOverView.delegate = self
        self.messageOverView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (user?["peopleMessaged"] == nil) {
            return 0
        }
        return ((user?["peopleMessaged"])! as! [PFUser]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messageOverView.dequeueReusableCell(withIdentifier: "MessageCell")! as! PersonMessagedCell
        
        let peopleMessaged: [PFUser] = user!["peopleMessaged"] as! [PFUser]
        cell.nameField.text = peopleMessaged[indexPath.row].username
        
        return cell
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
