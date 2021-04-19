//
//  DetailSearchTableViewCell.swift
//  Boiler Book
//
//  Created by arya sharma on 4/15/21.
//

import UIKit

class DetailSearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet var bookImage: UIImageView!
    
    @IBOutlet var titleBook: UILabel!
    
    @IBOutlet var authorBook: UILabel!
    
    @IBOutlet var priceBook: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()




    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
