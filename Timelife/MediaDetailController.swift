//
//  MediaDetail.swift
//  Timelife
//
//  Created by Giulia Zandonà on 25/06/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MediaDetailController: UIViewController {
    
    @IBAction func backToPhotoView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var titleMedia: UILabel!
    @IBOutlet weak var bodyMedia: UILabel!
    @IBOutlet weak var imegeMoodMedia: UIImageView!
    @IBOutlet weak var photoMedia: UIImageView!
    
    let carlo = UserDefaults.standard
    var idMedia = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("sono IDMEDIA: ", idMedia)

        
        let token = carlo.object(forKey: "token") as? String
        
        let headers:HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        Alamofire.request("http://timelife.test/api/media/" + idMedia, headers:headers).responseJSON{response in
            print(response.request as Any)
            print(response.response as Any)


            let data = response.result.value
            let json = JSON(data!)
            
            let title = "\(json["data"]["title"])"
            self.titleMedia.text = title
            print(title)
            
            let body = "\(json["data"]["body"])"
            self.bodyMedia.text = body
            print(body)
            
            var moodMedia = "\(json["data"]["mood"])"
            var moodImage = ""
            var imagePhoto = ""
            
            //COMMENTO MOMENTANEO IN PREVISIONE ALL'IMPLEMENTAZIONE DELLA VISUALIZZAZIONE E SALVATAGGIO DELLE FOTO
//            switch moodMedia {
//            case "good":
//                moodImage = "mood_good"
//
//            case "bad":
//                moodImage = "mood_bad"
//
//            case "love":
//                moodImage = "mood_love"
//
//            default:
//                moodImage = "empty"
//            }
            
            switch moodMedia {
            case "good":
                imagePhoto = "mageDiProvaGood"
                
            case "bad":
                imagePhoto = "mageDiProvaBad"
                
            case "love":
                imagePhoto = "mageDiProvaLove"
                
            default:
                imagePhoto = "addImage"
            }
            self.imegeMoodMedia.image = UIImage(named: moodImage )
            self.photoMedia.image = UIImage(named: imagePhoto )
        }
        
        bodyMedia.layer.masksToBounds = true
        bodyMedia.layer.cornerRadius = 10

        
        titleMedia.layer.masksToBounds = true
        titleMedia.layer.cornerRadius = 10
        
        
    }
}
