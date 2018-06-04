//
//  ThirdViewController.swift
//  Timelife
//
//  Created by Giulia Zandonà on 12/04/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addStory: UITextView!
    @IBOutlet weak var chooseImage: UIButton!
    
    @IBAction func backSecond(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupImagePickerButton()

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
    
}
