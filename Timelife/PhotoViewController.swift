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
    
    var calendarId = ""
    var date = ""
    var json = JSON()
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var plusBtn: UIButton!
    
    var photoTitle2 = Array<String>()
    var photoText2 = Array<String>()
    var mood = Array<String>()
    var image = ""
    let defaults = UserDefaults.standard
    let defaultsToken = UserDefaults.standard

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("PhotoViewController: parte il ViewDidAppear")
        //self.photoCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Sono entrato nei media")
        
        print(calendarId, "SONO NUMBER" )
        print(date, "SONO DATE")

        let token = defaultsToken.object(forKey: "token") as? String
        let headers:HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        let defaults = UserDefaults.standard.string(forKey: "calendarId")

        Alamofire.request("http://timelife.test/api/allmedia/" + calendarId, headers:headers).responseJSON{response in
            print(response.request as Any)
            print(response.response as Any)
            print("http://timelife.test/api/allmedia/" + self.calendarId)
            
            let data = response.result.value
            self.json = JSON(data!)
            print()
            
            for i in 0..<self.json.count {
                
                print(response.result.value)
                print(data!)
                
                let title = "\(self.json[i]["title"])"
                print(title)
                self.photoTitle2.append(title)
                self.photoCollectionView.reloadData()
                print(self.photoTitle2)
                print("titolo foto")
                
                let body  = "\(self.json[i]["body"])"
                print(body)
                self.photoText2.append(body)
                self.photoCollectionView.reloadData()
                print(self.photoText2)
                print("spiegazione foto")
                
                let moodshadow = "\(self.json[i]["mood"])"
                self.mood.append(moodshadow)
                self.photoCollectionView.reloadData()
                print(self.mood)
                print("spiegazione mood")
                print("\(i) times 5 is \(i * 5)")
                print(moodshadow)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var newPhotoCount = photoTitle2.count
        
        if (newPhotoCount > 2) {
            plusBtn.isHidden = true
        }
        return photoTitle2.count //quante celle vogliamo
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.photoTitle.text = photoTitle2[indexPath.row] //incrementa gli elementi di photoTitle
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
        
        switch mood[indexPath.row] {
        case "good":
            self.image = "mageDiProvaGood"
            
        case "bad":
            self.image = "mageDiProvaBad"
            
        case "love":
            self.image = "mageDiProvaLove"
            
        default:
            self.image = "addImage"
        }
        cell.image.image = UIImage(named: image)
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    
         return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Mi preparo per lo storeIdCalendar ")
        if (segue.identifier == "storeIdCalendar") {
            let view = segue.destination as! ThirdViewController
            view.calendarId = calendarId
            print("STO MANDANDO IL NUMBER NEL SEGUE", calendarId)
        }
        
        if (segue.identifier == "showDetail") {
            let view = segue.destination as! MediaDetailController
            
            if let itemIndex = photoCollectionView.indexPathsForSelectedItems?.first?.item {
                let selectedItem = self.json[itemIndex]["id"]
                view.idMedia = "\(selectedItem)"
                print("SONO L'ID DEL MEDIA SELEZIONATO: ", selectedItem)
            }
        }
    }
    
    @IBAction func backFirst(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
