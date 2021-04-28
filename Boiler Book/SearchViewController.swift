//
//  SearchViewController.swift
//  Boiler Book
//
//  Created by arya sharma on 4/11/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var text:String = ""
    

    var filteredClasses: [Class] = []
    var classes: [Class] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
      super.viewDidLoad()
        
      classes = Class.classes()
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Classes at Purdue University"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = Class.Category.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let indexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard
        segue.identifier == "ShowDetailSegue",
        let indexPath = tableView.indexPathForSelectedRow,
        let detailViewController = segue.destination as? DetailSearchViewController
        else {
          return
      }
      
        let class_: Class
        if isFiltering {
            class_ = filteredClasses[indexPath.row]
            detailViewController.text = class_.name
        } else {
            class_ = classes[indexPath.row]
            detailViewController.text = class_.name
        }
      //detailViewController.class_ = class_
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: Class.Category? = nil) {
      filteredClasses = classes.filter { (class_: Class) -> Bool in
        let doesCategoryMatch = category == .all || class_.category == category
        if isSearchBarEmpty {
            
            return doesCategoryMatch
        } else {
            return doesCategoryMatch && class_.name.lowercased()
                .contains(searchText.lowercased())
        }
      }
      
      tableView.reloadData()
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
  }

  extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredClasses.count
        }
        return classes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                               for: indexPath) as! ClassTableViewCell
        let class_: Class
        if isFiltering {
            class_ = filteredClasses[indexPath.row]
        } else {
            class_ = classes[indexPath.row]
        }
      cell.title.text = class_.name
      cell.subtitle.text = class_.category.rawValue
        
        if indexPath.row % 2 == 0 {
           // cell.backgroundCell.backgroundColor = .yellow
            cell.backgroundCell.backgroundColor = UIColor(red: 0.8078, green: 0.721568, blue: 0.5333, alpha: 1)
            //cell.backgroundColor = .black
        } else {
            cell.backgroundCell.backgroundColor = .black
           // cell.backgroundColor = UIColor(red: 0.8078, green: 0.721568, blue: 0.55294, alpha: 1)

            cell.title.textColor = .white
            cell.subtitle.textColor = .white

        }
        cell.backgroundColor = UIColor(red: 0.615686, green: 0.588235, blue: 0.5333, alpha: 1)
        
      return cell

    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
      let category = Class.Category(rawValue:
        searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
      filterContentForSearchText(searchBar.text!, category: category)
    }
}
    
    extension SearchViewController: UISearchBarDelegate {
      func searchBar(_ searchBar: UISearchBar,
          selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = Class.Category(rawValue:
          searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, category: category)
      }
    }



