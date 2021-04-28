//
//  MessageKitViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/28/21.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Parse

class MessageKitViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    var messageList: [PFObject] = [PFObject]()
    var user = PFUser.current()!
    var receiver: String?
    var receiverUsername: String?
    
    func currentSender() -> SenderType {
        return KitUser(id: user.username!, name: user["name"] as! String)
        
    }
    
    func setUpNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 45, width: UIScreen.main.bounds.width, height: 70))
        self.view.addSubview(navBar)
        navBar.items?.append(UINavigationItem(title: receiver!))
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(leavePage))
        navBar.topItem?.leftBarButtonItem = backButton
//        messagesCollectionView.insertSubview(navBar, at: 0)
    }
    
    @objc func leavePage() {
        self.dismiss(animated: true)
    }
    
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        let message = messageList[indexPath.section]
        let sender = KitUser(id: message["senderUsername"] as! String, name: message["sender"] as! String)
        
        return KitMessage(kind: MessageKind.text(message["text"] as! String), user: sender, messageId: String(indexPath.section), date: (message.createdAt)!)
        
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor.brown : UIColor.gray
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    @objc func loadMessages() {
        let query = PFQuery(className: "Message")
        
        query.findObjectsInBackground { (messages: [PFObject]!, error: Error?) in
            var newMessages: [PFObject] = [PFObject]()
            for message in messages {
                if (message["receiverUsername"] as? String == self.user.username
                    && message["senderUsername"] as? String == self.receiverUsername)
                    || (message["receiverUsername"] as? String == self.receiverUsername
                            && message["senderUsername"] as? String == self.user.username) {
                newMessages.append(message)
                }
            }
            self.messageList = newMessages
//            print("populated list with ", self.messageList?.count)
            //print(messages[1]["text"] as! String)
        }
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToLastItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0)
        setUpNavBar()
        
        loadMessages()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.loadMessages), userInfo: nil, repeats: true)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messageInputBar.delegate = self
        
        
        

        
        // Do any additional setup after loading the view.
    }

}

extension MessageKitViewController: InputBarAccessoryViewDelegate {

    @objc
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("tried clicking send?")
        let messageInput = text
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageInput
        chatMessage["senderUsername"] = PFUser.current()?.username
        chatMessage["sender"] = PFUser.current()!["name"]
        chatMessage["receiverUsername"] = receiverUsername
        chatMessage["receiver"] = receiver
        chatMessage["profilePicture"] = PFUser.current()!["profilePicture"]
        
        
        chatMessage.saveInBackground { (success, error) in
            self.loadMessages()
            if success {
                print("sent message")
                self.messageList.append(chatMessage)
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToLastItem()
            } else {
                print("did not send message")
            }
        }
        
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()
        inputBar.inputTextView.resignFirstResponder()
    }
}

internal struct KitMessage: MessageType {

    var messageId: String
    var sender: SenderType {
        return user
    }
    var sentDate: Date
    var kind: MessageKind

    var user: KitUser

    init(kind: MessageKind, user: KitUser, messageId: String, date: Date) {
        self.kind = kind
        self.user = user
        self.messageId = messageId
        self.sentDate = date
    }
}

internal struct KitUser: SenderType {
    
    var senderId: String
    var displayName: String
    
    init(id: String, name: String) {
        senderId = id
        displayName = name
    }
}
