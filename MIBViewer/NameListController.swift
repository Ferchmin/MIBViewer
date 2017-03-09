//
//  NameListController.swift
//  MIBViewer
//
//  Created by Pawel on 11.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import Foundation
import UIKit

class NameListController: UITableViewController, UISearchResultsUpdating {
    
    var nameList:[String]=[String]()
    let mibNameList = List_mib2()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameList = mibNameList.names
        
        self.title = "Names"
        UIApplication.shared.statusBarStyle = .default
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredNames.count
        }else{
             return nameList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameListCell", for: indexPath)
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredNames[indexPath.row]
        }else{
            cell.textLabel?.text = nameList[indexPath.row]
        }
        cell.selectionStyle = .blue
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let parentNav = self.presentingViewController as! UINavigationController
        let parent = parentNav.topViewController as! ViewController
        if searchController.isActive && searchController.searchBar.text != ""{
            parent.selectedObject = ReceivedObject(name: "", oid: "", value: "", type: "", ipAddress: "")
            parent.nameTextField!.text = filteredNames[indexPath.row]
             searchController.isActive = false
        }else{
            parent.selectedObject = ReceivedObject(name: "", oid: "", value: "", type: "", ipAddress: "")
            parent.nameTextField!.text = nameList[indexPath.row]
        }
            dismissView(self)
        
    }

    
    func filterContentForSearchText(searchText: String) {
        filteredNames = nameList.filter { name in
            return name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
    
    
}
