//
//  DetailSearchViewController.swift
//  Boiler Book
//
//  Created by arya sharma on 4/11/21.
//

import UIKit

class DetailSearchViewController: UIViewController {

        
    @IBOutlet var tableView: UITableView!
    
    var class_: Class? {
        didSet {
            configureView()
        }
    }
    override func viewDidLoad() {
      super.viewDidLoad()
      
      configureView()
    }
    
    func configureView() {
      //if let classes = class_,
        //let detailDescriptionLabel = detailDescriptionLabel,
        //let candyImageView = candyImageView {
        //detailDescriptionLabel.text = candy.name
        //candyImageView.image = UIImage(named: candy.name)
        //title = candy.category.rawValue
        //ADD SHIT IN
        
    }


}
