//
//  PersonMessagedCell.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/25/21.
//

import UIKit

class PersonMessagedCell: UITableViewCell {

    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var lastTextField: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var ppAdded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
