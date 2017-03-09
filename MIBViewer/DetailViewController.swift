//
//  DetailViewController.swift
//  MIBViewer
//
//  Created by Pawel on 07.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var object = ReceivedObject(name: "no data", oid: "no data", value: "no data", type: "no data", ipAddress: "no data")
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oidLabel: UILabel!
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        nameLabel.text = object.name
        oidLabel.text = object.oid
        ipAddressLabel.text = object.ipAddress
        typeLabel.text = object.type
        valueLabel.text = object.value
        
    }
    
}
