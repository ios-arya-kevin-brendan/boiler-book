//
//  PostCell.swift
//  Boiler Book
//
//  Created by Brendan Lee on 4/19/21.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var bookPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
