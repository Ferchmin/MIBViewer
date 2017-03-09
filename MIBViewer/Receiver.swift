//
//  Receiver.swift
//  MIBViewer
//
//  Created by Pawel on 03.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import Foundation

class ReceivedTable {
    
    var keys:[String]
    var values:[String]
    
    init(keys:[String], values:[String]){
        self.keys=keys
        self.values=values
    }
}

class Receiver {
    
    init(){
        
    }
    
    func createObject(from json:[String:AnyObject]?) -> ReceivedObject{
        
        var name = ""
        var oid = ""
        var value = ""
        var type = ""
        var ipAddress = ""
        
        if let jsonDictionary = json {
            
            if let tmpName = (jsonDictionary["Name"] as? String){
                name = tmpName
            }
            if let tmpOid = (jsonDictionary["Oid"] as? String){
                oid = tmpOid
            }
            if let tmpValue = (jsonDictionary["Value"] as? String) {
                value = tmpValue
            }
            if let tmpType = (jsonDictionary["Type"] as? String) {
                type = tmpType
            }
            if let tmpIpAddress = (jsonDictionary["IpAddress"] as? String) {
                ipAddress = tmpIpAddress
            }
            
        }
        return ReceivedObject(name: name,oid: oid, value: value, type: type, ipAddress: ipAddress)
        
    }
    
    func createTable(from json:[String:AnyObject]?) -> [ReceivedTable] {
        
        var tableOfTables=[ReceivedTable]()
        
        if let jsonDictionary = json {
            if let jsonObjectTable = jsonDictionary["Table"] as? [[String:AnyObject]] {
                
                for jsonObject in jsonObjectTable {
                    
                    // POBIERZ liste kluczy i pobierz z nich wartosci i wrzuc do zmiennych
                    
                    var keys = [String]()
                    var values = [String]()
                    
                    for key in jsonObject.keys{
                        keys.append(key)
                        values.append(jsonObject[key] as! String)
                    }
                    
                    let table = ReceivedTable(keys:keys, values:values)
                    tableOfTables.append(table)
                }
            
            }
        }
        return tableOfTables
    }

    
}
