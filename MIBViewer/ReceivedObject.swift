//
//  ReceivedGet.swift
//  MIBViewer
//
//  Created by Pawel on 03.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import Foundation

class ReceivedObject {
    
    var name:String!
    var oid:String!
    var value:String!
    var type:String!
    var ipAddress:String!
    
    init(name: String, oid:String, value: String, type:String, ipAddress:String){
        
        self.name = name
        self.oid = oid
        self.value = value
        self.type = type
        self .ipAddress = ipAddress
        
    }
}
