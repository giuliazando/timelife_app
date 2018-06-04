//
//  RegisterViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 13/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameRegister: UITextField!
    
    @IBOutlet weak var emailRegister: UITextField!
    
    
    @IBOutlet weak var passwordRegister: UITextField!
    
    @IBOutlet weak var confirmPasswordRegister: UITextField!
    
    @IBAction func btnRegister(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordRegister.isSecureTextEntry = true
        confirmPasswordRegister.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
