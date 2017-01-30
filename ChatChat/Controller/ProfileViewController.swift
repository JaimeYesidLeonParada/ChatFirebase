//
//  ProfileViewController.swift
//  ChatChat
//
//  Created by MACBOOK on 25/12/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var labelDisplayName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        let user = FIRAuth.auth()?.currentUser
        labelDisplayName.text = user?.displayName
        labelEmail.text = user?.email
        
        if let photoUrl = user?.photoURL {
            imageUser.sd_setImage(with: photoUrl, placeholderImage: UIImage.init(named: "placeholder-user"))
        }
    }
}

extension ProfileViewController {
    
    @IBAction func logoutAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "IdiomBox", message: "Are you sure did logout?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            FBSDKLoginManager().logOut()
            try! FIRAuth.auth()!.signOut()
            
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController : LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
           self.present(loginViewController, animated: true, completion: nil)
        }
        alertController.addAction(actionYes)
        self.present(alertController, animated: true, completion:nil)
    }
}
