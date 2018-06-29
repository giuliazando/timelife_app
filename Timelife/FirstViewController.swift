//
//  InterestCollectionViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 27/03/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var convertedDate = ""
    //var interest = Interest.fetchInterests()
    let cellScaling: CGFloat = 0.6
    var json = JSON()
    let defaults = UserDefaults.standard
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(defaults.string(forKey: "token"))
//        self.defaults.set(nil, forKey: "token")
        if((defaults.string(forKey: "token")) == nil) {
            print("foj")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginView")
            self.present(controller, animated: true, completion: nil)
        } else {
            let token = defaults.object(forKey: "token") as? String
            
            let headers:HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer \(token ?? "")"
            ]
            
            let userId = defaults.string(forKey: "userId")
            print("Sono l'userId: ", userId)
            
            Alamofire.request("http://timelife.test/api/calendar/" + userId!, method: .get, headers: headers).responseJSON { response in
                print(response)
                let data = response.result.value
                print(data!)
                self.json = JSON(data!)
                    
                print(self.json)
                self.collectionView.reloadData()
                //print(response)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 10.0
        let insetY = (view.bounds.height - cellHeight) / 10.0
        
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
}

extension FirstViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var newCount = json.count
        if (newCount == 0) {
            newCount = 1
        }
        print("NEW COUNT: ", newCount)

        return newCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath) as! CollectionViewCell
       
        if (json["message"] != "Unauthenticated.") {
            let dateFormatter = DateFormatter()

            var fullMood = ""
            
            if (json[indexPath.row]["medias"].count == 0) {
                let imageempty = "empty"
                cell.ImageView.image = UIImage(named: imageempty)
                
                if (json[indexPath.row]["calendar_date"].stringValue == "") {
                    let currentDate = Date()
                    dateFormatter.dateFormat = "dd MMMM yyyy"
                    let dateFinal = dateFormatter.string(from: currentDate)
                    cell.MonthName.text = dateFinal
                    print(currentDate)
                } else {
                    let currentDate = json[indexPath.row]["calendar_date"].stringValue
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateFromString = dateFormatter.date(from: currentDate)
                    dateFormatter.dateFormat = "dd MMMM yyyy"
                    let dateFinal = dateFormatter.string(from: dateFromString!)
                    cell.MonthName.text = dateFinal
                    print(currentDate)
                }

//                let currentDate = json[indexPath.row]["calendar_date"].stringValue
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let dateFromString = dateFormatter.date(from: currentDate)
//                dateFormatter.dateFormat = "dd MMMM yyyy"
//                let dateFinal = dateFormatter.string(from: dateFromString!)
//                cell.MonthName.text = dateFinal
//                print(currentDate)
            }
            else {
                print(json[indexPath.row])
                let dateString = json[indexPath.row]["calendar_date"].stringValue
                print(dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "dd MMMM yyyy"
                let dateFinal = dateFormatter.string(from: dateFromString!)
                cell.MonthName.text = dateFinal
                print("data cambiata: " + dateFinal)
                print(dateFinal, "sono la DATAAAAAAA")
            
            
                print(dateFinal)
            }
        
            for i in 0..<json[indexPath.row]["medias"].count {
                fullMood = fullMood + json[indexPath.row]["medias"][i]["mood"].stringValue
            }
            print("STO SOMMANDO I MOOD")
            
            var imagename = ""
            
            switch fullMood {
            case "good","goodgood","goodgoodgood":
                imagename = "good"
                
            case "bad","badbad","badbadbad":
                imagename = "bad"
                
            case "love","lovelove","lovelovelove":
                imagename = "love"
        case"lovegood","goodlove","lovelovegood","goodgoodlove","lovegoodlove","goodlovelove","goodlovegood","goodgoodlove","lovegoodgood":
                imagename = "lovegood"
                
            case "lovebad","badlove","badbadlove","lovelovebad","badlovebad","lovebadlove","lovebadbad","badlovelove":
                imagename = "lovebad"
                
            case "goodbad","badgood","badbadgood","goodgoodbad","badgoodbad","goodbadgood","goodbadbad","badgoodgood":
                imagename = "goodbad"
                
            case "goodbadlove","goodlovebad","lovebadgood","lovegoodbad","badlovegood","badgoodlove" :
                imagename = "goodbadlove"
            default:
                imagename = "empty"
            }
            cell.ImageView.image = UIImage(named: imagename)
            print("SONO IL MOOD: ", fullMood)
        }
        return cell
    }
    
   //ciò che stampa se clicco sulla cella
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "saveIdCalendar", sender: nil)
        print("immagine \(indexPath.row)")
        
    }
    
    //questa funzione serve per capire qual è l'id_calendar corrispondente alla card selezionata dal carosello.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveIdCalendar") {
            let view = segue.destination as! PhotoViewController
            
        if  let itemIndex = collectionView.indexPathsForSelectedItems?.first?.item {
            let selectedItem = self.json[itemIndex]["id"]
            view.calendarId = "\(selectedItem)"
            print("SONO L'ID_CALENDAR: ", self.json[itemIndex]["id"])
            }
        }
    }
}

extension FirstViewController : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


