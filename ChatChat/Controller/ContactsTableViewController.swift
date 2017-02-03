//
//  ContactsTableViewController.swift
//  ChatChat
//
//  Created by MACBOOK on 29/01/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ContactsTableViewController: UITableViewController {
    
    // MARK: Properties
    var contacts : NSArray! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        requestContactsFB()
    }
    
    //MARK: Helpers
    func requestContactsFB() {
        var tokenString = ""
    
        if (FBSDKAccessToken.current() != nil){
            tokenString = FBSDKAccessToken.current().tokenString
        }
        else if ((UserDefaults.standard.value(forKey: "FBSDKAccessToken.tokenString")) != nil){
            tokenString = (UserDefaults.standard.value(forKey: "FBSDKAccessToken.tokenString") as? String)!
        }
        
        let request : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/friends", parameters: nil, tokenString: tokenString, version: nil, httpMethod:"GET")
        request.start(completionHandler: { (connection, result, error) -> Void in
            if error == nil {
                let resultdict = result as! NSDictionary
                self.contacts = resultdict.object(forKey: "data") as! NSArray
                
                if self.contacts.count > 0 {
                    self.tableView.reloadData()
                }
            }
        })
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "Cell"
        let valueDict : NSDictionary = contacts[indexPath.row] as! NSDictionary
        let name = valueDict.object(forKey: "name") as! String
        let id = valueDict.object(forKey: "id") as! String
        let urlPicture = ("https://graph.facebook.com/\(id)/picture?type=large") as NSString
        
        let cell = UITableViewCell(style:UITableViewCellStyle.value1, reuseIdentifier: reuseIdentifier)
        cell.detailTextLabel?.text = "facebook"
        cell.textLabel?.text = name
        cell.imageView?.sd_setImage(with: NSURL(string: urlPicture as String)! as URL, placeholderImage: UIImage(named:"placeholder-user"))
        
        return cell
    }
}
