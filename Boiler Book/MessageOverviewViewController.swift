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
    var senders: [PFObject] = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageOverView.delegate = self
        self.messageOverView.dataSource = self
        // Do any additional setup after loading the view.
//        performSegue(withIdentifier: "toChat", sender: nil)
        updateSender()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateSender), userInfo: nil, repeats: true)
    }
    
    @objc func updateSender() {
        let query = PFQuery(className: "Message")
        
        query.findObjectsInBackground { (messages: [PFObject]!, error: Error?) in
            var newSenders: [PFObject] = [PFObject]()
            for message in messages {
                if message["receiverUsername"] as? String == self.user?.username
                    || message["senderUsername"] as? String == self.user?.username {
                    var foundMessage = false
                    for n in 0..<newSenders.count {
                        if (newSenders[n]["senderUsername"] as! String == message["senderUsername"] as! String
                        && newSenders[n]["receiverUsername"] as! String == message["receiverUsername"] as! String) ||
                            (newSenders[n]["senderUsername"] as! String == message["receiverUsername"] as! String && newSenders[n]["receiverUsername"] as! String == message["senderUsername"] as! String){
                            foundMessage = true
                            newSenders[n] = message
                        }
                    }
                    if !foundMessage {
                        newSenders.append(message)
                    }
                }
            }
            self.senders = newSenders
            //self.parseMessages = messages
            //self.messages.reloadData()
        }
        self.messageOverView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked thing")
        performSegue(withIdentifier: "toKitChat", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messageOverView.dequeueReusableCell(withIdentifier: "MessageCell")! as! PersonMessagedCell
        
        var userToGet: String
        if senders[indexPath.row]["senderUsername"] as? String == user?.username {
            cell.nameField.text = senders[indexPath.row]["receiver"] as? String
            userToGet = (senders[indexPath.row]["receiverUsername"] as? String)!
        } else {
            cell.nameField.text = senders[indexPath.row]["sender"] as? String
            userToGet = (senders[indexPath.row]["senderUsername"] as? String)!
        }
        cell.lastTextField.text = senders[indexPath.row]["text"] as? String
        
        let findUsers:PFQuery = PFUser.query()!;
        findUsers.whereKey("username",  equalTo: userToGet)
//        print(userToGet)
        findUsers.findObjectsInBackground { (user: [PFObject]?, error: Error?) in
//            print(user)
            if !cell.ppAdded {
                let rawImageFile = (user![0] as! PFUser)["profilePicture"]
                if rawImageFile != nil {
                    let imageFile = rawImageFile as! PFFileObject
                    let urlString = imageFile.url!
                    let url = URL(string: urlString)!
                
                    cell.profilePicture.af.setImage(withURL: url)
                    cell.profilePicture.layer.cornerRadius = cell.profilePicture.bounds.width/2
                    cell.ppAdded = true
                }
            }
        }
        
//        let query = PFQuery(
//        print("made it here")
//        query.findObjectsInBackground { (users: [PFObject]?, error: Error?) in
//            print(users)
////            for user in users {
////                print(user)
////                print((user as! PFUser).username)
////            }
//        }
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepping screen")
        if (segue.identifier == "toChat") {
            let chatPage = segue.destination as! MessageViewController
            chatPage.receiver = senders[sender as! Int]["senderUsername"] as! String
            if (senders[sender as! Int]["senderUsername"] as! String) == user?.username {
                chatPage.receiver = senders[sender as! Int]["receiver"] as! String
                chatPage.receiverUsername = senders[sender as! Int]["receiverUsername"] as! String
            } else {
                chatPage.receiver = senders[sender as! Int]["sender"] as! String
                chatPage.receiverUsername = senders[sender as! Int]["senderUsername"] as! String
            }
        } else if segue.identifier == "toKitChat" {
            let chatPage = segue.destination as! MessageKitViewController
            chatPage.receiver = senders[sender as! Int]["senderUsername"] as! String
            if (senders[sender as! Int]["senderUsername"] as! String) == user?.username {
                chatPage.receiver = senders[sender as! Int]["receiver"] as! String
                chatPage.receiverUsername = senders[sender as! Int]["receiverUsername"] as! String
            } else {
                chatPage.receiver = senders[sender as! Int]["sender"] as! String
                chatPage.receiverUsername = senders[sender as! Int]["senderUsername"] as! String
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
