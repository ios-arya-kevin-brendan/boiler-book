//
//  ClassTableViewCell.swift
//  Boiler Book
//
//  Created by arya sharma on 4/14/21.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    
    @IBOutlet var backgroundCell: UIView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundCell.layer.cornerRadius = 10
        //background.layer.cornerRadius = 10

        backgroundCell.clipsToBounds = true
        //background.clipsToBounds = true
        //background.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
