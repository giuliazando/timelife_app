//
//  UserViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 28/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserViewController: UIViewController {

    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var countryUser: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    let carlo = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = carlo.object(forKey: "token") as? String
        
        let headers:HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        let userId = UserDefaults.standard.string(forKey: "userId")
        
        JsonManager.sharedInstance.manager.request("https://timelifeweb.test/api/user/" + userId!, headers: headers).responseJSON{response in
            print(response.request as Any)
            print(response.response as Any)
            print(userId)
            
            let data = response.result.value
            let json = JSON(data!)
            print(data!)
            
            let name = "\(json["name"])"
            self.nameUser.text = name
            print(name)

            let email  = "\(json["email"])"
            self.emailUser.text = email
            print(email)

            let country = "\(json["location"])"
            self.countryUser.text = country
            print(country)
        }
        
        
        //self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.layer.cornerRadius = 50
        self.userImage.clipsToBounds = true
    }

        // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToInterest(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
}
