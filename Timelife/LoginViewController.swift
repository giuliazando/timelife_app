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
    
   
    @IBAction func backToLog(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
        JsonManager.sharedInstance.manager.request("https://timelifeweb.test/api/user/6").responseJSON { response in
            /*print(response.request as Any)  // original URL request
             print(response.response as Any) // URL response
             print(response.result.value as Any)   // result of response serialization
             */
            let data = response.result.value
            let json = JSON(data!)
            print(json)
            print(json.count)
            
            for i in 0..<json["data"].count {
                print("\(json["data"][i]["id"])")
            }
        }
    }
}
