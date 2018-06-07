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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var photoText: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
  
    var photoTitle2 = Array<String>()
    var photoText2 = Array<String>()

    let image = [UIImage(named: "vacanze-invernali"), UIImage(named: "prendere-il-sole"), UIImage(named: "vaso-rotto")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        JsonManager.sharedInstance.manager.request("http://timelifeweb.test/api/media/4").responseJSON{response in
            print(response.request as Any)
            print(response.response as Any)
            
            let data = response.result.value
            let json = JSON(data!)
            print(json["data"])
            print(data)
            
            let title = "\(json["data"]["title"])"
            print(title)
            self.photoTitle2.append(title)
            self.photoCollectionView.reloadData()
            print(self.photoTitle2)
            
            let body  = "\(json["data"]["body"])"
            print(body)
            self.photoText2.append(body)
            self.photoCollectionView.reloadData()
            print(self.photoText2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoTitle2.count      //quante celle vogliamo
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.photoTitle.text = photoTitle2[indexPath.row] //incrementa gli elementi di photoTitle
        cell.image.image = image[indexPath.row]
        cell.photoText.text = photoText2[indexPath.row]
       
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
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


