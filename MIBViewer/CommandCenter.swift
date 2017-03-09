//
//  CommandCenter.swift
//  MIBViewer
//
//  Created by Pawel on 29.12.2016.
//  Copyright © 2016 PawelLearning. All rights reserved.
//

import Foundation

class CommandCenter {
    
    var MIBURL:URL!
    let nameList = List_mib2()
    var oidFromName = [String]()
    
    let baseMIBURL:URL = URL(string: "http://192.168.63.153:8080/api/request/")!
    
    init(){
        MIBURL = baseMIBURL
    }
    
    func createRequest(serverIP:String,hostIP:String, requestType:String, name:String, completion: @escaping ([String:AnyObject]?)->Void,  completionWithWrongStatus: @escaping ([String:AnyObject]?)->Void) {
        
        MIBURL = URL(string: "http://\(serverIP):8080/api/request/\(requestType)?requestedname=\(name)&requestedipaddress=\(hostIP)")
        print(MIBURL.absoluteString)
        let networkOperation = NetworkOperation(url: MIBURL!)
        networkOperation.downloadJSONFromURL(completion: completion, completionWithWrongStatus: completionWithWrongStatus)
        
    }
    
    func createRequest(serverIP:String,hostIP:String, requestType:String, name:String, oid:String, completion: @escaping ([String:AnyObject]?)->Void,  completionWithWrongStatus: @escaping ([String:AnyObject]?)->Void) {
        if oid == ""{
            MIBURL = URL(string: "http://\(serverIP):8080/api/request/\(requestType)?requestedname=\(name)&requestedipaddress=\(hostIP)")
        }else{
            MIBURL = URL(string: "http://\(serverIP):8080/api/request/\(requestType)?requestedname=\(name)&requestedipaddress=\(hostIP)&requestedoid=\(oid)")
        }
        print(MIBURL.absoluteString)
        let networkOperation = NetworkOperation(url: MIBURL!)
        networkOperation.downloadJSONFromURL(completion: completion, completionWithWrongStatus: completionWithWrongStatus)
    }
    
}
