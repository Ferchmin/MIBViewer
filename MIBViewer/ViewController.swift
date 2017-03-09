//
//  ViewController.swift
//  MIBViewer
//
//  Created by Pawel on 29.12.2016.
//  Copyright © 2016 PawelLearning. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var commandTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var objectTableView: UITableView!
    @IBOutlet var commandPicker:UIPickerView! = UIPickerView()
    @IBOutlet weak var goButton: UIButton!
    
    
    
    
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    
    let pickerData = ["Get", "GetNext", "GetTable", "Watch"]
    let nameList = List_mib2()
    
    var objects:[ReceivedObject] = [ReceivedObject]()
    var receivedTableOfTables:[ReceivedTable] = [ReceivedTable]()
    var selectedObject:ReceivedObject!{
        didSet{
            DispatchQueue.main.async {
                if self.selectedObject.name != "" {
                    self.nameTextField.text = self.selectedObject.name
                }

            }
        }
    }
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    let commandCenter = CommandCenter()
    let receiver = Receiver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        selectedObject = ReceivedObject(name: "", oid: "", value: "", type: "", ipAddress: "")
        configureCommandPicker()
        configureTextFields()
       
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 67, green: 188, blue: 255, alpha: 1), NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 18)!]
        
    }
    
    
    func configureCommandPicker(){
        commandPicker.delegate = self
        commandPicker.dataSource = self
        commandPicker.backgroundColor = .white
    }
    
    func configureTextFields(){
        
        ipTextField.keyboardType = .decimalPad
        serverTextField.keyboardType = .decimalPad
        nameTextField.keyboardType = .default
        
        ipTextField.delegate = self
        serverTextField.delegate=self
        nameTextField.delegate = self
        nameTextField.text = "sysUpTime"
        nameTextField.addTarget(self, action: #selector(self.showNameList), for: UIControlEvents.touchDown)
        commandTextField.delegate = self
        commandTextField.inputView = commandPicker
        commandTextField.returnKeyType = .done
        commandTextField.text = pickerData[commandPicker.selectedRow(inComponent: 0)]
        
        numberToolbar.barStyle = .default
        
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.endEditing))
        ]
        
        numberToolbar.sizeToFit()
        
        ipTextField.inputAccessoryView = numberToolbar
        serverTextField.inputAccessoryView = numberToolbar
        commandTextField.inputAccessoryView = numberToolbar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func showNameList(){
        performSegue(withIdentifier: "showNameList", sender: self)
    }
    
    @IBAction func goButton(_ sender: Any) {
        
        endEditing()
        
        goButton.isEnabled = false
        
        if self.commandPicker.selectedRow(inComponent: 0) == 3 {
            performSegue(withIdentifier: "showWatch", sender: self)
            
            
        }else if self.commandPicker.selectedRow(inComponent: 0)==0 {

            //Tworzy i wysyla request http
            commandCenter.createRequest(serverIP:serverTextField.text!, hostIP: ipTextField.text!, requestType: commandTextField.text!, name: nameTextField.text!, completion: {
                (JSONDictionary) in
                
                let object = self.receiver.createObject(from: JSONDictionary)
                self.objects.append(object)
                self.selectedObject = object
                
                
                
                
                DispatchQueue.main.async {
                    
                    //Zmiana pola OID
                    if let nextName = object.name {
                        self.nameTextField.text = nextName
                    }
                    
                    
                    //Tu wyswietlasz dane na ekranie
                    self.objectTableView.beginUpdates()
                    self.objectTableView.insertRows(at: [IndexPath(row: self.objects.count-1, section: 0)], with: .automatic)
                    self.objectTableView.endUpdates()
                    
                    let indexPath = IndexPath(row: self.objects.count-1, section: 0)
                    self.objectTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
                    
                    
                }
            }, completionWithWrongStatus: {
                (JSONDictionary) in
                
                if let json = JSONDictionary {
                    if let message = json["Message"] as? String {
                        
                        self.showAlert(tittle: "Mib Browser", message: message, actionTitle: "Ok")
                        
                    }
                }else{
                   self.showAlert(tittle: "Mib Browser", message: "Server is not responding", actionTitle: "Ok")
                    
                }
            })

            
        }else if self.commandPicker.selectedRow(inComponent: 0)==1 {
            
            
            //Tworzy i wysyla request http
            
            commandCenter.createRequest(serverIP:serverTextField.text!, hostIP: ipTextField.text!, requestType: commandTextField.text!, name: nameTextField.text!, oid: selectedObject.oid,  completion: {
                (JSONDictionary) in
                
                let object = self.receiver.createObject(from: JSONDictionary)
                self.objects.append(object)
                self.selectedObject = object
                
                
                DispatchQueue.main.async {
                    
                    //Zmiana pola OID
                    if let nextName = object.name {
                        self.nameTextField.text = nextName
                    }
                    
                    
                    //Tu wyswietlasz dane na ekranie
                    self.objectTableView.beginUpdates()
                    self.objectTableView.insertRows(at: [IndexPath(row: self.objects.count-1, section: 0)], with: .automatic)
                    self.objectTableView.endUpdates()
                    
                    let indexPath = IndexPath(row: self.objects.count-1, section: 0)
                    self.objectTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
                    
                    
                }
            }, completionWithWrongStatus: {
                (JSONDictionary) in
                
                if let json = JSONDictionary {
                    if let message = json["Message"] as? String {
                        
                        self.showAlert(tittle: "Mib Browser", message: message, actionTitle: "Ok")
                        
                    }
                }else{
                    self.showAlert(tittle: "Mib Browser", message: "Server is not responding", actionTitle: "Ok")
                    
                }
            })

            
        }else if self.commandPicker.selectedRow(inComponent: 0)==2 {
            
            
            commandCenter.createRequest(serverIP:serverTextField.text!, hostIP: ipTextField.text!, requestType: commandTextField.text!, name: nameTextField.text!, completion: {
                (JSONDictionary) in
                
                let receivedTables = self.receiver.createTable(from: JSONDictionary)
                self.receivedTableOfTables = receivedTables 
                
                
                DispatchQueue.main.async {
                    self.activityView.removeFromSuperview()
                    self.performSegue(withIdentifier: "showTable", sender: self)
                }
                
                
                },completionWithWrongStatus: {
                (JSONDictionary) in
                
                if let json = JSONDictionary {
                    if let message = json["Message"] as? String {
                    
                        self.showAlert(tittle: "Mib Browser", message: message, actionTitle: "Ok")
                        
                    }
                }else{
                    
                    self.showAlert(tittle: "Mib Browser", message: "Server is not responding", actionTitle: "Ok")
                    
                }
            })
            
            activityView.center = self.view.center
            activityView.startAnimating()
            
            self.view.addSubview(activityView)
            
        }
        self.goButton.isEnabled=true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = self.objectTableView.indexPathForSelectedRow {
                let detailView = segue.destination as! DetailViewController
                detailView.object = objects[indexPath.row]
                selectedObject = objects[indexPath.row]
            }
        }else if segue.identifier == "showWatch" {
            
            let nav = segue.destination as! UINavigationController
            let watchView = nav.topViewController as! WatchViewController
            watchView.ip = ipTextField.text
            watchView.name = nameTextField.text
            watchView.serverIP = serverTextField.text
        }else if segue.identifier == "showTable" {
            let nav = segue.destination as! UINavigationController
            let getTableView = nav.topViewController as! TableViewController
            getTableView.receivedTables = receivedTableOfTables
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForSpecialObject(object:ReceivedObject) -> Bool{
        var flag = false
        for name in nameList.specialNames {
            if object.name == name {
                flag = true
            }
        }
        return flag
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
    
    func endEditing(){
        view.endEditing(true)
    }
    
    func showAlert(tittle:String,message:String,actionTitle:String){
        
        DispatchQueue.main.async {
            self.activityView.removeFromSuperview()
            let alertController = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        commandTextField.text = pickerData[row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.textLabel?.text = objects[indexPath.row].name
        cell.detailTextLabel?.text = objects[indexPath.row].value
        cell.selectionStyle = .none
        return cell
    }

    
    
    //Testing functions
    func addFakeObject(){
        let object1 = ReceivedObject(name: "SysUpTime", oid: ".1.3.6.0", value: "Wartosc", type: "Integer", ipAddress: "127.0.0.1")
        objects.append(object1)
        
        self.objectTableView.beginUpdates()
        self.objectTableView.insertRows(at: [IndexPath(row: self.objects.count-1, section: 0)], with: .automatic)
        self.objectTableView.endUpdates()
        
        let indexPath = IndexPath(row: self.objects.count-1, section: 0)
        self.objectTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
        
    }
    
//    func addFakeTableOfObjects(){
//        var tempReceivedTable:[ReceivedTable] = [ReceivedTable]()
//        for i in 1...5 {
//            let keys = ["klucz1","klucz2","klucz3"]
//            let values = ["wartosc1","wartosc2","wartosc3"]
//            let table = ReceivedTable(keys:keys,values:values)
//            tempReceivedTable.append(table)
//        }
//        receivedTableOfTables = tempReceivedTable
//    }

    
}

