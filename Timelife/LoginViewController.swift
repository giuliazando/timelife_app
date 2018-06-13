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
            "client_secret": "8nU2NfksHN6XYUITGtWHBJ3UsiiJpUykG1SuoqQ8",
            "username": addEmail.text!,
            "password": addPassword.text!,
            "scope": "*"
        ]
        
        print(addEmail)
        JsonManager.sharedInstance.manager.request("https://timelifeweb.test/oauth/token", method: .post, parameters: parameters).responseJSON { response in
            let data = response.result.value
            let json = JSON(data!)
            if(json["message"] == JSON.null) {
                self.defaults.set("\(json["access_token"])", forKey: "token")
                print(json["access_token"])
                self.dismiss(animated: true, completion: nil)
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let controller = storyboard.instantiateViewController(withIdentifier: "homeView")
//                self.present(controller, animated: true, completion: nil)
            }
            else {
                print(json["message"])
            }
        }
    }
}
