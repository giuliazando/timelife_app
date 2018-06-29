//
//  DateViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 30/04/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire

class DateViewController: UIViewController {


    @IBOutlet weak var dataText: UILabel!
    @IBOutlet weak var selectDate: UIDatePicker!
  
    @IBAction func chooseBtn(_ sender: Any) {
        
        let userId = UserDefaults.standard.string(forKey: "userId")
        let carlo = UserDefaults.standard
        
        let token = carlo.object(forKey: "token") as? String

        let headers : HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        let parameters : Parameters = [
            "mood" : "empty",
            "calendar_date" : dataText.text
        ]

        Alamofire.request("http://timelife.test/api/calendar/" + userId!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            print(response)
            switch response.result {
            case .success:
                print(response)
                print("ho inviato qualcosa al server")
                print(response)
                break
            case .failure(let error):
                print("voglio morire")
                print(error)
            }
        }
        
    }
    
    @IBAction func pickerDataAction(_ sender: Any) {
        scomponiDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! FirstViewController
        view.convertedDate = self.dataText.text!
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate: NSDate = NSDate() //variabile data di oggi e dico che è una data
        selectDate.maximumDate = currentDate as Date //qui dico che la data massima deve essere la data di oggi
        dataText.text = "\(selectDate.date)"
    }
    
    func scomponiDate() {
        let dateFormatter = DateFormatter()
        var convertedDate: String!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        convertedDate = dateFormatter.string(from: selectDate.date)
        dataText.text = convertedDate
        print(convertedDate, "sono la data convertita")
        
        var giornodelmese: Int!
        var mesedellanno: Int!
        var anno: Int!
        
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day, .month, .year] , from: selectDate.date)
        
        giornodelmese = components.day
        mesedellanno = components.month
        anno = components.year
        
        print("Il giorno d'oggi è \(giornodelmese!), il mese \(mesedellanno!) e l'anno \(anno!)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backDate(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
