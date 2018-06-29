//
//  RegisterViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 13/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var confirmPasswordRegister: UITextField!
    @IBOutlet weak var genderRegister: UISegmentedControl!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    @IBAction func backToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    var selectedCountry = "Afghanistan"
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = pickerData[row]
        print(selectedCountry)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pickerData = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"]
        
        passwordRegister.isSecureTextEntry = true
        confirmPasswordRegister.isSecureTextEntry = true
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if (nameRegister.text == "" || emailRegister.text == "" || passwordRegister.text == "" || confirmPasswordRegister.text == "") {
            
            let alert = UIAlertController(title: "Error", message: "Please fill all the required fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        else {
            if (passwordRegister.text != confirmPasswordRegister.text) {
                let alert = UIAlertController(title: "Error", message: "Password and confirm password don't match!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            else {

                self.dismiss(animated: true, completion: nil)
                
                var gender = ""
                if (genderRegister.selectedSegmentIndex == 0) {
                    gender = "male"
                }
                
                else {
                    gender = "female"
                }
                
                let parameters: Parameters = [
                    "name" : nameRegister.text!,
                    "email" : emailRegister.text!,
                    "password" : passwordRegister.text!,
                    "password_confirmation" : confirmPasswordRegister.text!,
                    "gender" : gender,
                    "location" : selectedCountry
                ]
                print(parameters)
                
                Alamofire.request("http://timelife.test/api/register", method: .post, parameters: parameters).responseJSON { response in
                    let data = response.result.value
                    let json = JSON(data!)
                    
                    print(data)
                    print(json)
                    print("\(json["id"])")
                    let idUser = "\(json["id"])"
                    
                    if (json["error"] != JSON.null) {
                        print("ERRORE NELLA COMPILAZIONE DEL REGISTER")
                        
                    } else {
                        print("COMPILAZIONE DEL REGISTER ANDATA A BUON FINE")
                        
                        let parametersForToken : Parameters = [
                            "grant_type" : "password",
                            "client_id": 1,
                            "client_secret": "i7q4XrVF4RZD7kaHuxsLBFSd33HXijhCc0wouY7Z",
                            "username": self.emailRegister.text!,
                            "password": self.passwordRegister.text!,
                            "scope": "*"
                        ]
                        print(parametersForToken)
                        Alamofire.request("http://timelife.test/api/oauth/token", method: .post, parameters: parametersForToken).responseJSON { response in
                            let data = response.result.value
                            let json = JSON(data!)
                            let defaults = UserDefaults.standard
                            print(json)
                            defaults.set("\(json[0]["access_token"])", forKey: "token")
                            print("\(json[0]["access_token"])" + " TOKEN GENERATO DAL REGISTER")
                            defaults.set("\(json[0]["id"])", forKey: "userId")
                            self.performSegue(withIdentifier: "goToHome", sender: nil)
                    }
                }
            }
        }
    }
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
