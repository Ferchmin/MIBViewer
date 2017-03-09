//
//  WatchViewController.swift
//  MIBViewer
//
//  Created by Pawel on 08.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import UIKit

class WatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var iterationsTextField: UITextField!
    @IBOutlet weak var objectTable: UITableView!
    @IBOutlet weak var goButton: UIButton!
    
    var commandCenter = CommandCenter()
    var receiver = Receiver()
    
    var objects:[ReceivedObject] = [ReceivedObject]()
    var timesRepeated:Int = 0
    var iterations:Int = 0
    var name:String!
    var ip:String!
    var serverIP:String!
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray, NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 18)!]
        
        secondsTextField.keyboardType = .decimalPad
        iterationsTextField.keyboardType = .decimalPad
        
    }
    
    
    @IBAction func GoButton(_ sender: Any) {
        secondsTextField.endEditing(true)
        iterationsTextField.endEditing(true)
        
        let seconds:Double!
        
        if let trySeconds = Double((secondsTextField?.text)!){
            seconds = trySeconds
        }else {
            showAlert(tittle: "MIB Browser", message: "Wrong seconds value", actionTitle: "Ok")
            seconds = 1
            secondsTextField?.text = "1"
        }
        
        if let tryIterations = Int((iterationsTextField?.text!)!) {
            iterations = tryIterations
        }else{
            showAlert(tittle: "MIB Browser", message: "Wrong iterations value", actionTitle: "Ok")
            iterations = 1
            iterationsTextField?.text = "1"
        }
        
    
        sendCommand()
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector:#selector(WatchViewController.sendCommand), userInfo: nil, repeats: true)
    }
    
    func sendCommand(){
        
        goButton.isEnabled = false
        
        commandCenter.createRequest(serverIP:serverIP, hostIP: ip, requestType: "Get", name: name, completion: {
            (JSONDictionary) in
            
            let object = self.receiver.createObject(from: JSONDictionary)
            self.objects.append(object)
            
            
            DispatchQueue.main.async {
                
                //Tu wyswietlasz dane na ekranie
                self.objectTable.beginUpdates()
                self.objectTable.insertRows(at: [IndexPath(row: self.objects.count-1, section: 0)], with: .automatic)
                self.objectTable.endUpdates()
                
                let indexPath = IndexPath(row: self.objects.count-1, section: 0)
                self.objectTable.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
                
            }
        }, completionWithWrongStatus: {
            (JSONDictionary) in
            
            if let json = JSONDictionary {
                if let message = json["Message"] as? String {
                    self.showAlert(tittle: "MIB Browser", message: message, actionTitle: "Ok")
                }
            }else{
                
                self.showAlert(tittle: "MIB Browser", message: "Server is not responding", actionTitle: "Ok")
                
            }
        })
        timesRepeated += 1
        if timesRepeated >= iterations {
            timer.invalidate()
            timesRepeated=0
            goButton.isEnabled = true
        }

    }
    
    func showAlert(tittle:String,message:String,actionTitle:String){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchCell", for: indexPath)
        cell.textLabel?.text = objects[indexPath.row].name
        cell.detailTextLabel?.text = objects[indexPath.row].value
        cell.textLabel?.textColor = .darkGray
        cell.detailTextLabel?.textColor = .darkGray
        cell.selectionStyle = .none
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWatchDetail"{
            if let indexPath = self.objectTable.indexPathForSelectedRow {
                let detailView = segue.destination as! DetailViewController
                detailView.object = objects[indexPath.row]
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func DismissSegue(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UIApplication.shared.statusBarStyle = .lightContent
    }


}
