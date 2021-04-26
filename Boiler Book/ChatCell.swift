//
//  ChatCell.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/25/21.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageContent: UILabel!
    
    var fromSender = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
