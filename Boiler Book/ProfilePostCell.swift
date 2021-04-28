//
//  ProfilePostCell.swift
//  Boiler Book
//
//  Created by Kevin Bates on 4/28/21.
//

import UIKit

class ProfilePostCell: UITableViewCell {

    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
