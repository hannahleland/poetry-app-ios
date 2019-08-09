//
//  PoetModel.swift
//  Poetria
//
//  Created by Hannah Leland on 8/6/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import Foundation

//
// currently unused. will utilize later
//

class PoetModel: NSObject {
    
    //  VARIABLES
    var poetId : String?
    var username : String?
    var password : String?
    var email : String?
    
    // empty constructor
    override init() {}
    
    // contruct with parameters
    init(poetId: String?, username: String?, password : String?, email : String?) {
        self.poetId = poetId
        self.username = username
        self.password = password
        self.email = email
    } // end init(poetId, username, password, email)
    
    // print object's current state
    override var description: String {
        return ("petId: \(poetId.debugDescription), Username: \(username.debugDescription), Password: \(password.debugDescription), Email: \(email.debugDescription)")
    } // end override description
    
} // end PoetModel
