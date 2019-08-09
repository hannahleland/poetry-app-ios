//
//  LoginController.swift
//  Poetria
//
//  Created by Hannah Leland on 8/3/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import UIKit

// conforms to the PoetProtocol for communicating with the PoetController class
class LoginController: UIViewController, PoetProtocol {
    
    // CONSTANTS
    let poetController = PoetController()
    
    // VARIABLES
    var jsonResult : [[String:Any]] = []
    
    // OUTLETS
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting self as delegate of PoetController's PoetProtocol
        poetController.delegate = self
        
    } // end viewDidLoad()
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        // this triggers the PoetController login() method. data will be sent back via the loginResponse method
        poetController.login(with: username, and: password)
        
    } // end logInButtonPressed
    
    
    // a method of PoetProtocol. this will receive an array of dictionaries -- [[String:Any]] -- from the PoetController
    func loginResponse(json: [[String:Any]]) {
        
        print("and we back!")
        jsonResult = json
        print("Login JSON result: \(json.description)") // *victory dance*
        
        // TODO: change UI in repsponse to json result from server
        
    } // end loginResponse()
    
} // end LoginController
