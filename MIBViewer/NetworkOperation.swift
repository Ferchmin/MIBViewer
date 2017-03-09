//
//  NetworkOperation.swift
//  MIBViewer
//
//  Created by Pawel on 29.12.2016.
//  Copyright © 2016 PawelLearning. All rights reserved.
//

import Foundation
import UIKit

class NetworkOperation {
    
    
    var config: URLSessionConfiguration = URLSessionConfiguration.default
    var session:URLSession
    let queryURL:URL
    
    
    init(url:URL){
        session = URLSession(configuration: config)
        queryURL = url
    }
    
    func downloadJSONFromURL(completion: @escaping ([String:AnyObject]?)->Void, completionWithWrongStatus: @escaping ([String:AnyObject]?)->Void){
        
        var request:URLRequest = URLRequest(url: queryURL)
        request.timeoutInterval = 20.0
        let dataTask = session.dataTask(with: request, completionHandler: {( data, response, error) in
        
            if let httpResponse = response as? HTTPURLResponse {
                switch(httpResponse.statusCode){
                case 200:
                    // Create JSON object with data
                    let jsonDictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    completion(jsonDictionary!)
                default:
                    // Create JSON object with data
                    let jsonDictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    completionWithWrongStatus(jsonDictionary!)
                }
            }else{
                completionWithWrongStatus(nil)
            }
        
        })
            dataTask.resume()
        }
    
    }
    
    
