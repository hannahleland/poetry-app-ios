//
//  Poet.swift
//  Poetria
//
//  Created by Hannah Leland on 8/6/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import Foundation

protocol PoetProtocol : class {
    func loginResponse(json: [[String:Any]])
    
} // end PoetProtocol

class PoetController {
    
    weak var delegate : PoetProtocol!
    
    func signup(with username: String, _ password: String, and email: String) {
            let url = URL(string : "https://hleland.com/api/poetria/user/signup.php?username\(username)&password=\(password)&email=\(email)")
        // TODO: stuff
        
    } // end signup()
    
    func login(with username: String, and password: String) {
        
            print("login() data values = UN: \(username) PW: \(password)")
            guard let url = URL(string : "https://hleland.com/api/poetria/user/login.php?username=\(username)&password=\(password)") else { return }
        
            callApi(url: url)
        
    } // end login()
    
    func callApi(url: URL) {
        print("callApi begin")
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data {
                print("Task response: \(String(data.debugDescription))")
                if error == nil {
                    self.parseJSON(data)
                } else {
                    print("URLSession error downloading data: \(error.debugDescription)")
                    return
                }
            } // end if let data
            
        } // end task
        
        task.resume()
        
    } // end callApi()
    
    
    func parseJSON(_ data: Data) {
        print("parseJSON begin")
        var jsonArray = [[String:Any]]()
        do {
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                print("jsonResult failed")
                return
            }
            print("jsonResult: \(jsonResult)")
            
            let jsonDictionary = jsonResult as! [String : Any]
            print("jsonDictionary: \(jsonDictionary)")
            
            for dictionary in jsonDictionary {
                jsonArray.append([dictionary.key:dictionary.value])
            }
            print("jsonArray: \(jsonArray.description)")
            
            DispatchQueue.main.async(execute: { () -> Void in
                print("we in the main thread")
                self.delegate.loginResponse(json: jsonArray)
            })
            
        } catch {
            print("Catch error: \(error)")
        } // end do catch
        
        
    } // end parseJSON()
    
} // end Poet
