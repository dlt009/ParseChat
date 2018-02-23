//
//  ChatViewController.swift
//  ParseChat
//
//  Created by David Tan on 2/22/18.
//  Copyright © 2018 DavidTan. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    var messages = [PFObject]()
    
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = messageTextField.text ?? ""
        let currentUser = PFUser.current()!
        
        let message = PFObject(className: "Message")
        message["text"] = chatMessage
        message["user"] = currentUser
        
        message.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = (message["text"] as! String)
        
        return cell
    }
    
    // Refresh messages
    @objc func onTimer() {
        // Add code to be run periodically
        getMessages()
        self.tableView.reloadData()
    }
    
    // Query messages from Parse
    func getMessages() {
        let query = PFQuery(className:"Message")
        
        query.addAscendingOrder("createdAt")
        query.includeKey("user")
        
        query.findObjectsInBackground { (objects:[PFObject]?, error: Error?) -> Void in
            if error==nil{
                print("Successfully Retrieved \(objects!.count) Many Messages")
                self.messages = objects!
            }
            else{
                print("Error: Failed to get messages")
            }
            
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
