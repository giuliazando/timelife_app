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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var addEmail: UITextField!
    
    @IBOutlet weak var addPassword: UITextField!


    @IBAction func loginButton(_ sender: Any) {
 /*       Alamofire.request("https://api.openweathermap.org/data/2.5/weather?q=\(writeCity.text!)&APPID=45d9dc59e6c3becff84ddabc49e9d9ec")  .responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // URL response
            //print(response.result.value as Any)   // result of response serialization
            let data = response.result.value
            let json = JSON(data!)
            print(json["data"])
            let city = "\(json["name"])"
            self.cityLabel.text = city
            let gradi  = "Gradi: " + "\(json["main"]["temp"])" + "F°"
            self.gradiLabel.text = gradi
            let meteo  = "Il tempo è: " + "\(json["weather"][0]["description"])" // 0 sta per la tonda
            self.meteoLabel.text = meteo
            let country = "\(json["sys"]["country"])"
            self.countryLabel.text = country
        }*/
    }
    
   
    /*func isValidEmail(addEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: addEmail)
    }*/
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
