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
import Kingfisher

class MediaDetailController: UIViewController {
    
    var idMedia = ""
    
    @IBAction func backToPhotoView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func deleteBtn(_ sender: Any) {
        print("premo il bottone di delete")
        Alamofire.request("http://timelife.test/api/media/" + idMedia, method: .delete).responseJSON { response in
                if (response.result.isSuccess) {
                    print("sono nel success del delete")
                    self.dismiss(animated: true, completion: nil)
                }
                    
                else {
                    print("sono nel failure del delete")
                    let alert = UIAlertController(title: "Error", message: "Connection error, please retry.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
        }
    }
    
    @IBOutlet weak var titleMedia: UILabel!
    @IBOutlet weak var bodyMedia: UILabel!
    @IBOutlet weak var imegeMoodMedia: UIImageView!
    @IBOutlet weak var photoMedia: UIImageView!
    
    let defaultsToken = UserDefaults.standard
            
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sono IDMEDIA: ", idMedia)

        
        let token = defaultsToken.object(forKey: "token") as? String
        
        let headers:HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        
        Alamofire.request("http://timelife.test/api/media/" + idMedia, headers:headers).responseJSON{response in
            print(response.request as Any)
            print(response.response as Any)

            let data = response.result.value
            let json = JSON(data!)
            print(json)

            let title = "\(json["data"]["title"])"
            self.titleMedia.text = title
            print(title)
            
            let body = "\(json["data"]["body"])"
            self.bodyMedia.text = body
            print(body)

            let urlModif = URL(string: "\(json["data"]["mediaUrl"])")
            print(json["data"]["mediaUrl"])
            self.photoMedia.kf.setImage(with: urlModif)
            
            
            
            
            var moodMedia = "\(json["data"]["mood"])"
            var moodImage = ""
            var imagePhoto = ""
            print("SONO IL moodMedia: ", moodMedia)
            
            //COMMENTO MOMENTANEO IN PREVISIONE ALL'IMPLEMENTAZIONE DELLA VISUALIZZAZIONE E SALVATAGGIO DELLE FOTO
            switch moodMedia {
            case "good":
                moodImage = "mood_good"

            case "bad":
                moodImage = "mood_bad"

            case "love":
                moodImage = "mood_love"

            default:
                moodImage = "empty"
            }
            
//            switch moodMedia {
//            case "good":
//                imagePhoto = "mageDiProvaGood"
//
//            case "bad":
//                imagePhoto = "mageDiProvaBad"
//
//            case "love":
//                imagePhoto = "mageDiProvaLove"
//
//            default:
//                imagePhoto = "addImage"
//            }
            self.imegeMoodMedia.image = UIImage(named: moodImage )
            //self.photoMedia.image = UIImage(named: imagePhoto )
        }
        
        bodyMedia.layer.masksToBounds = true
        bodyMedia.layer.cornerRadius = 10

        titleMedia.layer.masksToBounds = true
        titleMedia.layer.cornerRadius = 10
    }
}
