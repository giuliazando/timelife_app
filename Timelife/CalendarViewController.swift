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
    
    var NumberOfEmpytyBox = Int() // il numero di "empty boxes" all'inizio del mese corrente
    var nextNumberOfEmpytyBox = Int() // il numero di "empty boxes" del prossimo mese
    var previousNumberOfEmptyBox = 0 // il numero di "empty boxes" del mese precedente
    var Direction = 0 // =0 se si è nel mese corrente , =1 se si è in un mese futuro , =-1 se si è in un mese passato
    var positionIndex = 0 // qui si memorizzano le variabili soprastanti di "empty boxes".


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
            Direction = 1
            
            getStartDateDayPosition()
            
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        default:
            month += 1
            Direction = 1
            
            getStartDateDayPosition()
            
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
            Direction = -1
            
            getStartDateDayPosition()

            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        default:
            month -= 1
            Direction = -1
            
            getStartDateDayPosition()

            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calendar.reloadData()
        }
    }
    
    
    func getStartDateDayPosition(){ // la funzione dà il numero di "empty boxes"
        switch Direction {
        case 0:                     // se sei al mese corrente
            switch day{
            case 1...7:
                NumberOfEmpytyBox = weekday - day
            case 8...14:
                NumberOfEmpytyBox = weekday - day - 7
            case 15...21:
                NumberOfEmpytyBox = weekday - day - 14
            case 22...28:
                NumberOfEmpytyBox = weekday - day - 21
            case 29...31:
                NumberOfEmpytyBox = weekday - day - 28
            default:
                break
            }
            positionIndex = NumberOfEmpytyBox
            
        case 1:                                                                 // se sei al mese futuro
            nextNumberOfEmpytyBox = (positionIndex + daysInMonths[month])%7
            positionIndex = NumberOfEmpytyBox
            
        case -1:                                                                // se sei al mese precedente
            previousNumberOfEmptyBox = (7 - (daysInMonths[month] - positionIndex)%7)
            if previousNumberOfEmptyBox == 7 {
                previousNumberOfEmptyBox = 0
            }
            positionIndex = previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction { //ritorna il numero di giorni nel mese + il numero di "empty boxes" basato sulla direzione che noi siamo andando
        case 0:
            return daysInMonths[month] + NumberOfEmpytyBox
        case 1...:
            return daysInMonths[month] + nextNumberOfEmpytyBox
        case -1:
            return daysInMonths[month] + previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier:"Calendar", for: indexPath) as! DateCollectionViewCell
        
        calendarCell.backgroundColor = UIColor.clear
       
        if calendarCell.isHidden {
            calendarCell.isHidden = false
        }
        
        switch Direction {
        case 0:
            calendarCell.dateLabel.text = "\(indexPath.row + 1 - NumberOfEmpytyBox)"
        case 1...:
            calendarCell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmpytyBox)"
        case -1:
            calendarCell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(calendarCell.dateLabel.text!)! < 1{
            calendarCell.isHidden = true
        }
        
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(calendarCell.dateLabel.text!)! > 0 {
            }
        default:
            break
        }
        if currentMonth == months[calendario.component(.month, from: date) - 1] && year == calendario.component(.year, from: date) && indexPath.row + 1 == day{
            calendarCell.backgroundColor = UIColor.red
        }
        
        return calendarCell
    }
    
    @IBAction func backToCarosell(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

