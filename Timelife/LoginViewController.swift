//
//  LoginViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 02/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController  {
    
    @IBOutlet weak var addEmail: UITextField!
    @IBOutlet weak var addPassword: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addPassword.isSecureTextEntry = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        print("il pulsante funziona")
        let parameters : Parameters = [
            "grant_type" : "password",
            "client_id": 1,
            "client_secret": "i7q4XrVF4RZD7kaHuxsLBFSd33HXijhCc0wouY7Z",
            "username": addEmail.text!,
            "password": addPassword.text!,
            "scope": "*"
        ]
        
        print(addEmail)
        JsonManager.sharedInstance.manager.request("https://timelifeweb.test/api/oauth/token", method: .post, parameters: parameters).responseJSON { response in
            let data = response.result.value
            let json = JSON(data!)
            if(json["message"] == JSON.null) {
                let carlo = UserDefaults.standard
                
                
                carlo.set("\(json[0]["access_token"])", forKey: "token")
                print(carlo.string(forKey: "token"))
                print("\(json[0]["access_token"])" + " ciaomamma")
                self.dismiss(animated: true, completion: nil)
                
                //mi serve per salvare id utente
                carlo.set("\(json[0]["id"])", forKey: "userId")
                print(carlo.string(forKey: "userId"))
      
            }
            else {
                print(json["message"])
                print(self.addEmail.text!)
                print(self.addPassword.text!)
            }
        }
    }
}
