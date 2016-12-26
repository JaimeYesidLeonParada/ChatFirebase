//
//  ProfileViewController.swift
//  ChatChat
//
//  Created by MACBOOK on 25/12/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var labelDisplayName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = FIRAuth.auth()?.currentUser
        let photoUrl = user?.photoURL
        
        labelDisplayName.text = user?.displayName
        labelEmail.text = user?.email
        print("Pgoto: \(photoUrl)")
        
    }
    
}
