//
//  ThirdViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 12/04/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addStory: UITextView!
    @IBOutlet weak var chooseImage: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    
    let defaultsToken = UserDefaults.standard
    var moodSelection: String?
    var saveTitle: String?
    var saveStory: String?
    var calendarId = ""
    var date = ""

    @IBAction func goodButton(_ sender: Any) {
        loveButton.alpha = 0.3
        badButton.alpha = 0.3
        goodButton.alpha = 1
        moodSelection = "good"
    }
    
    @IBAction func lovebutton(_ sender: Any) {
        goodButton.alpha = 0.3
        badButton.alpha = 0.3
        loveButton.alpha = 1
        moodSelection = "love"
    }
    
    @IBAction func badButton(_ sender: Any) {
        loveButton.alpha = 0.3
        goodButton.alpha = 0.3
        badButton.alpha = 1
        moodSelection = "bad"
    }
    
    @IBAction func backToDate(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDiaryDay(_ sender: Any) {
        if (addTitle.text == "" || addStory.text == "" || moodSelection == nil) {
            let alert = UIAlertController(title: "Error", message: "Please fill all the required fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            sendMedia()
            saveTitle = addTitle.text
            print("sto salvando il titolo")
            print(saveTitle!)
            
            saveStory = addStory.text
            print("sto salvando il testo")
            print(saveStory!)

            self.presentingViewController?.dismiss(animated: true)

            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupImagePickerButton()
        addStory.layer.masksToBounds = true
        addStory.layer.cornerRadius = 10
    }
    
    func setupImagePickerButton()
    {
        chooseImage.addTarget(self, action: #selector(ThirdViewController.displayImagePickerButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(chooseImage)
        
    }
    @objc func displayImagePickerButtonTapped(_ sender:UIButton!) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        addImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        addImage.backgroundColor = UIColor.clear
        addImage.contentMode = UIViewContentMode.scaleAspectFill
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMedia() {
    
        print("Sono entrato nella funzione sendMedia")
        let token = defaultsToken.object(forKey: "token") as? String
        
        let headers : HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        let parameters : Parameters = [
            "mood": self.moodSelection!,
            "title": self.addTitle.text!,
            "body": self.addStory.text!,
            "type": "photo",
            "date": date,
            "mediaUrl": "https://cdn.modernfarmer.com/wp-content/uploads/2017/12/Funny-Sheep-Facts.jpg"
        ]
        print("SONO IL CALENDAR ID: ", calendarId)
        
        Alamofire.request("http://timelife.test/api/media/" + calendarId, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("sono nel success")
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error)
                print(parameters)
                print("http://timelife.test/api/media/" + self.calendarId)
            }
        }
        
        //let urlString = "https://timelifeweb.test/api/media"
        
        print("questo è il mood che viene salvato: " + "\(String(describing: parameters["mood"]))")
        
        //let data = MultipartFormData()
      
        
        //print("sono il data ", data)

        
        //CHIAMATA POST MultipartFormData PER IL SALVATAGGIO DELLE IMMAGINI NELL'APP
        
//            if let image = addImage.image {
//                print("ALMENO QUI")
//                let imageData = UIImageJPEGRepresentation(image, 1.0)
//
//                let urlString = "http://timelife.test/api/media/" + calendarId;
//                print("http://timelife.test/api/media/" + self.calendarId)
//
//                let session = URLSession(configuration: URLSessionConfiguration.default)
//
//                let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
//
//                mutableURLRequest.httpMethod = "GET"
//
//                let boundaryConstant = "----------------12345";
//                let contentType = "multipart/form-data;boundary=" + boundaryConstant
//                mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
//
//                // create upload data to send
//                let uploadData = NSMutableData()
//
//                // add image
//                uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
//                uploadData.append("Content-Disposition: form-data; name=\"picture\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
//                uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
//                uploadData.append(imageData!)
//                uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
//
//                mutableURLRequest.httpBody = uploadData as Data
//                print("SMERALDOVERDE")
//
//                let task = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
//
//                    print(response)
//
//                    if error == nil {
//                        print("sono nell'if")
//                        print(response)
//                    }
//                    else {
//                        print("sono nell'else")
//                        print(parameters)
//                        print(response)
//                        print(error)
//                    }
//                })
//                print(task.state)
//                print("sono task: ", task)
//                task.resume()
//        }
    }
}
