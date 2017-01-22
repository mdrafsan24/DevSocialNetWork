//
//  ViewController.swift
//  DevSocial
//
//  Created by Rafsan Chowdhury on 1/13/17.
//  Copyright © 2017 Mcraf. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.passwordField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            //WTF GOING ON??
            print("Yoooo ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        /* Recap: 
         FB button tapped and we ask for permission just for the email.
         Based on FB authentication, we get an access token, and then we create a credential.
        */
 
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authinticate with FACEBOOK! - \(error)")
            } else if result?.isCancelled == true {
                print("User cancelled FB authentication")
            } else {
                print("Succesfully logged in with FB")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                self.performSegue(withIdentifier: "goToFeed", sender: nil)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        /* Recap:
         Just authenticating using firebase...!
         */
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print ("Unable to authinticate with Firebase - \(error)")
            } else {
                if let user = user {
                    let userData = ["provider" : credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData) // Saves!
                }
                print("Successfully authinticated with firebase")
            }
        })
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("MD: User authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: (user.uid), userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("MD UNABLE TO AUTHENTICATE WITH FIREBASE")
                        } else {
                            print("successfully authenticated")
                            if let user = user {
                                
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: (user.uid), userData: userData)
                                self.performSegue(withIdentifier: "goToFeed", sender: nil)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        
        print("Data saved to KeyChain")
        
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

