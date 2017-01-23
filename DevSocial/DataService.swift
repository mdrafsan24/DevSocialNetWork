//
//  DataService.swift
//  DevSocial
//
//  Created by Rafsan Chowdhury on 1/21/17.
//  Copyright © 2017 Mcraf. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference() // URL of root of database which is basically 
// Root = https://devsocial-fa82a.firebaseio.com/ 

let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    //Singleton = Single instance of a class
    
    static let ds = DataService()
    
    // DB References
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts") // Goind into the "posts" object in firebase DB
    private var _REF_USERS = DB_BASE.child("users")
    
    //Storage References
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics") //FOLDER NAME
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) { // Send in ID and Data
        
        REF_USERS.child(uid).updateChildValues(userData) // UID doesn't exist creates a child object
        //updateChildValues simply override data for the objects that already exists
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
