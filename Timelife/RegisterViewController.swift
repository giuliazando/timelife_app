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
    
    
    @IBOutlet weak var countryPicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    
    
    @IBAction func btnRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        
        passwordRegister.isSecureTextEntry = true
        confirmPasswordRegister.isSecureTextEntry = true
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
