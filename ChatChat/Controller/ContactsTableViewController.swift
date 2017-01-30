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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        requestContactsFB()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Helpers
    func requestContactsFB() {
        /* make the API call */
        
        var tokenString = ""
    
        if (FBSDKAccessToken.current() != nil) {
            //They are logged in so show another view
            tokenString = FBSDKAccessToken.current().tokenString
        }
        else if ((UserDefaults.standard.value(forKey: "FBSDKAccessToken.tokenString")) != nil){
            tokenString = (UserDefaults.standard.value(forKey: "FBSDKAccessToken.tokenString") as? String)!
        }
        else {
            //They need to log in
            print("Disque no esta logeado")
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let reuseIdentifier = "Cell"
        let cell = UITableViewCell(style:UITableViewCellStyle.value1, reuseIdentifier: reuseIdentifier)
        
        //cell.imageView?.image = UIImage(named:"placeholder-user")
        //cell.textLabel?.text = "Amigo"
        cell.detailTextLabel?.text = "facebook"
        
        
        let valueDict : NSDictionary = contacts[indexPath.row] as! NSDictionary
        let name = valueDict.object(forKey: "name") as! String
        
        cell.textLabel?.text = name
        
        let id = valueDict.object(forKey: "id") as! String
        let urlPicture = ("https://graph.facebook.com/\(id)/picture?type=large") as NSString
        
        cell.imageView?.sd_setImage(with: NSURL(string: urlPicture as String)! as URL, placeholderImage: UIImage(named:"placeholder-user"))
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
