//
//  AuthenticationViewController.swift
//  todoapp
//
//  Created by Monica Grigorovici - (p) on 12/2/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class AuthenticationViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton.init(frame: self.loginContainerView.bounds)
        loginButton.delegate = self
        
        self.loginContainerView.addSubview(loginButton)
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let _ = error {
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let _ = error {
                return
            }
            
            if let user = authResult?.user {
                mainApplication.user = user
                mainApplication.loadProjectsFromDatabase()
                self.performSegue(withIdentifier: Segues.PostAuthenticationSegue, sender: nil)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}
