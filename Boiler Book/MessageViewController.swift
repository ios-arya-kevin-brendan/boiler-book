//
//  MessageViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/21/21.
//

import UIKit
import MessageKit
import Parse

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messages: UITableView!
    var messagesArray: [String] = [String]()
    @IBOutlet weak var messageInput: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var parseMessages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messages.delegate = self
        self.messages.dataSource = self
        messages.separatorStyle = .none
        
        loadMessages()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.loadMessages), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onSend(_ sender: Any) {
        if messageInput.text == "" || messageInput.text == nil {
            return
        }
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageInput.text ?? ""
        chatMessage["senderUsername"] = PFUser.current()?.username
        chatMessage["user"] = PFUser.current()!["name"]
        chatMessage.saveInBackground { (success, error) in
            self.loadMessages()
            self.messageInput.text = ""
            if success {
                print("sent message")
            } else {
                print("did not send message")
            }
        }
        
    }
    
    @objc func loadMessages() {
        let query = PFQuery(className: "Message")
        
        query.findObjectsInBackground { (messages: [PFObject]!, error: Error?) in
            self.parseMessages = messages
            self.messages.reloadData()
            //print(messages[1]["text"] as! String)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.messages.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
    
        cell.messageContent.text = parseMessages[indexPath.row]["text"] as? String
        
        
        if parseMessages[indexPath.row]["senderUsername"] as? String == PFUser.current()?.username {

            cell.messageContent.textAlignment = .right
        } else {
            cell.messageContent.textAlignment = .left
        }
        
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
