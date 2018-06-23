//
//  DateViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 30/04/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {


    @IBOutlet weak var dataText: UILabel!
    @IBOutlet weak var selectDate: UIDatePicker!
    @IBOutlet weak var saveDate: UIButton!
    @IBAction func backDate(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickerDataAction(_ sender: Any) {
        scomponiDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! FirstViewController
        view.date = self.dataText.text!
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
        dateFormatter.dateFormat = "dd/MM/yyyy"
        convertedDate = dateFormatter.string(from: selectDate.date)
        dataText.text = convertedDate
        
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
    
}
