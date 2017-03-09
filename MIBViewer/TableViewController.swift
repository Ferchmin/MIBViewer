//
//  TableViewController.swift
//  MIBViewer
//
//  Created by Pawel on 11.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var objectTable: UITableView!
    var receivedTables:[ReceivedTable]=[ReceivedTable]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray, NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 18)!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedTables[0].keys.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return receivedTables.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Row #\(section+1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        cell.textLabel?.text = receivedTables[indexPath.section].keys[indexPath.row]
        cell.detailTextLabel?.text = receivedTables[indexPath.section].values[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    
    @IBAction func DismissSegue(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
}
