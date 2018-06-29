//
//  PhotoView.swift
//  Timelife
//
//  Created by Giulia Zandonà on 26/03/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //prima era ViewController
    
    var number = ""
    var date = ""
     var json = JSON()
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
  
    var photoTitle2 = Array<String>()
    var photoText2 = Array<String>()
    var mood = Array<String>()
    let defaults = UserDefaults.standard
    
    let carlo = UserDefaults.standard

    let image = [UIImage(named: "vacanze-invernali"), UIImage(named: "prendere-il-sole"), UIImage(named: "vaso-rotto")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Sono entrato nei media")
        
        print(number, "SONO NUMBER" )
        print(date, "SONO DATE")
        
        let token = carlo.object(forKey: "token") as? String
        
        let headers:HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        let pippo = UserDefaults.standard.string(forKey: "calendarId")

        
        Alamofire.request("http://timelife.test/api/allmedia/" + number, headers:headers).responseJSON{response in
            print(response.request as Any)
            print(response.response as Any)
            print(pippo, "SONO PIPPO")
            
            let data = response.result.value
            let json = JSON(data!)

            for i in 0..<json.count {
                
            
                print(response.result.value)
                print(data!)
                
                let title = "\(json[i]["title"])"
                print(title)
                self.photoTitle2.append(title)
                self.photoCollectionView.reloadData()
                print(self.photoTitle2)
                print("titolo foto")
                
                let body  = "\(json[i]["body"])"
                print(body)
                self.photoText2.append(body)
                self.photoCollectionView.reloadData()
                print(self.photoText2)
                print("spiegazione foto")
                
                let moodshadow = "\(json[i]["mood"])"
                print(moodshadow)
                self.mood.append(moodshadow)
                self.photoCollectionView.reloadData()
                print(self.mood)
                print("spiegazione mood")

                print("\(i) times 5 is \(i * 5)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Mi preparo per lo storeIdCalendar ")
        if (segue.identifier == "storeIdCalendar") {
            let view = segue.destination as! ThirdViewController
            
            if  let itemIndex = photoCollectionView.indexPathsForSelectedItems?.first?.item {
                //let selectedItem = self.json[itemIndex]["id"]
                let selectedItem = "\(json[0]["id"])"
                print(selectedItem, "sono id")
                view.number = number
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var newPhotoCount = photoTitle2.count
        if (newPhotoCount == 0) {
            newPhotoCount = 1
        }
        return photoTitle2.count //quante celle vogliam
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    
        //if
        cell.photoTitle.text = photoTitle2[indexPath.row] //incrementa gli elementi di photoTitle
        //cell.image.image = image[indexPath.row]
        cell.photoText.text = photoText2[indexPath.row]
        
        print(indexPath.row)
       
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 3.0
        cell.contentView.layer.borderWidth = 5.0

        switch mood[indexPath.row] {
        case "bad":
            cell.contentView.layer.borderColor = UIColor.purple.cgColor
        case "good":
            cell.contentView.layer.borderColor = UIColor.yellow.cgColor
        case "love":
            cell.contentView.layer.borderColor = UIColor.red.cgColor
        default:
            cell.contentView.layer.borderColor = UIColor.gray.cgColor
        }
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    
         return cell
    }
        
    @IBAction func backFirst(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


