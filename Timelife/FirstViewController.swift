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
    
    
    //var interest = Interest.fetchInterests()
    let cellScaling: CGFloat = 0.6
    var json = JSON()
    let defaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.defaults.set(nil, forKey: "token")
        if((defaults.object(forKey: "token") as? String) == nil) {
            print("foj")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginView")
            self.present(controller, animated: true, completion: nil)
        } else {
            let token = defaults.object(forKey: "token") as? String
            
            let Headers:HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer \(token ?? "")"
            ]
            
            JsonManager.sharedInstance.manager.request("http://timelifeweb.test/api/calendar", headers: Headers).responseJSON { response in
                let data = response.result.value
                print(data!)
                self.json = JSON(data!)
                print(self.json)
                self.collectionView.reloadData()
                print(response)
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
        
        let token = defaults.object(forKey: "token") as? String
        
        let Headers:HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        JsonManager.sharedInstance.manager.request("http://timelifeweb.test/api/calendar", headers: Headers).responseJSON { response in
            let data = response.result.value
            print(data!)
            self.json = JSON(data!)
            print(self.json)
            self.collectionView.reloadData()
            print(response)
        }
    }
}

extension FirstViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(interest.count)
        
        return json.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath) as! CollectionViewCell
        
        //data modificata: da yyyy-MM-dd HH:mm:ss a dd MMMM yyyy
        print(json)
    
        if (json["message"] != "Unauthenticated.") {
            let dateString = json[indexPath.row]["date"].stringValue
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFromString = dateFormatter.date(from: dateString)
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let dateFinal = dateFormatter.string(from: dateFromString!)
            cell.MonthName.text = dateFinal
            print("data cambiata: " + dateFinal)
            
            var imagename = ""
            switch json[indexPath.row]["mood"].stringValue {
            case "good":
                imagename = "good"
                
            case "bad":
                imagename = "bad"
                
            case "love":
                imagename = "love"
                
            case "lovegood","goodlove":
                imagename = "lovegood"
                
            case "lovebad","badlove":
                imagename = "lovebad"
                
            case "goodbad","badgood":
                imagename = "goodbad"
                
            case "goodbadlove","goodlovebad","lovebadgood","lovegoodbad","badlovegood","badgoodlove" :
                imagename = "goodbadlove"
            default:
                imagename = "empty"
            }
            
            cell.ImageView.image = UIImage(named: imagename)
        }
        

        return cell
    }
    
   //ciò che stampa se clicco sulla cella
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("immagine \(indexPath.row)")
        
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


