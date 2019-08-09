//
//  Poet.swift
//  Poetria
//
//  Created by Hannah Leland on 8/6/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import Foundation

// definition of the PoetProtocol. allows other classes,structs, etc to access certain features of PoetController
protocol PoetProtocol : class {
    func loginResponse(json: [[String:Any]])
    
} // end PoetProtocol

class PoetController {
    
    // TODO: research what "weak" and "strong" mean
    weak var delegate : PoetProtocol!
    
    // TODO: finish writing this method
    func signup(with username: String, _ password: String, and email: String) {
            let url = URL(string : "https://hleland.com/api/poetria/user/signup.php?username\(username)&password=\(password)&email=\(email)")
        // TODO: stuff
        
    } // end signup()
    
    // this method is called from LoginViewController, with 2 parameters
    func login(with username: String, and password: String) {
        
            print("login() data values = UN: \(username) PW: \(password)")
            guard let url = URL(string : "https://hleland.com/api/poetria/user/login.php?username=\(username)&password=\(password)") else { return }
        
            // calling the API
            callApi(url: url)
        
    } // end login()
    
    
    // communicating with the server, to retrieve a JSON response
    func callApi(url: URL) {
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data {
                print("Task response: \(String(data.debugDescription))")
                if error == nil {
                    // sending the data response to be parsed
                    self.parseJSON(data)
                } else {
                    print("URLSession error downloading data: \(error.debugDescription)")
                    return
                }
            } // end if let data
            
        } // end task
        
        task.resume()
        
    } // end callApi()
    
    
    // taking the json data and swift-ifying it
    func parseJSON(_ data: Data) {
        print("parseJSON begin")
        var jsonArray = [[String:Any]]()
        
        // going asynchronous!
        do {
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                print("jsonResult failed")
                return
            }
            print("jsonResult: \(jsonResult)")
            
            let jsonDictionaries = jsonResult as! [String : Any]
            print("jsonDictionary: \(jsonDictionaries)")
            
            // this for-in loop made this function finally work. i didn't see any examples like this
            for dictionary in jsonDictionaries {
                jsonArray.append([dictionary.key:dictionary.value]) // a thing of beauty
            }
            print("jsonArray: \(jsonArray.description)")
            
            // re-emerging onto the main thread
            DispatchQueue.main.async(execute: { () -> Void in
                print("we in the main thread")
                // telling the delegte that we have the parsed data and we're sending it back
                self.delegate.loginResponse(json: jsonArray)
            }) // end main thread dispatch
            
        } catch {
            print("Catch error: \(error)")
        } // end do catch
        
    } // end parseJSON()
    
} // end Poet
