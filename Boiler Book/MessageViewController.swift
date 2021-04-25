//
//  MessageViewController.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/21/21.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messages: UITableView!
    var messagesArray: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messages.delegate = self
        self.messages.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.messages.dequeueReusableCell(withIdentifier: "MessageCell")! as UITableViewCell
        
        cell.textLabel?.text = self.messagesArray[indexPath.row]
        
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
