//
//  CalendarViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 04/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    

    
    let months = ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"]
    
    let daysOfMonth = ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato", "Domenica"]
    
    var daysInMonths = [31,28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonth = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth = months[month]
        
        monthLabel.text = "\(currentMonth) \(year)"
    }
    
    @IBAction func next(_ sender: Any) {
        switch currentMonth {
        case "Dicembre":
            month = 0
            year += 1
            
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        default:
            month += 1
            
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        }
    }
    
    @IBAction func previous(_ sender: Any) {
        switch currentMonth {
        case "Gennaio":
            month = 11
            year -= 1
            
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        default:
            month -= 1
            
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInMonths[month]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier:"Calendar", for: indexPath) as! DateCollectionViewCell
    
        calendarCell.backgroundColor = UIColor.clear
        calendarCell.dateLabel.text = "\(indexPath.row + 1)"
        return calendarCell
    }
    @IBAction func backToCarosell(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

