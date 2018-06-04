//
//  Interest.swift
//  Timelife
//
//  Created by Giulia Zandonà on 27/03/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit

class Interest
{

    //var title = ""
    var ImageView: UIImage
    var color: UIColor
    var day: String
    var month: String
    
    
    init(ImageView: UIImage, color: UIColor, day: String, month: String)
    {
        //self.title = title
        self.ImageView = ImageView
        self.color = color
        self.day = day
        self.month = month
    }
    

    static func fetchInterests() -> [Interest]
    {
    return [
        Interest(ImageView: UIImage(named: "f1")!, color: UIColor(red: 149/255.0, green: 229/255.0, blue: 66/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f2")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f3")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f4")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f5")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f6")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f7")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao", month: "AGOSTO"),
            Interest(ImageView: UIImage(named: "f8")!, color: UIColor(red: 26/255.0, green: 39/255.0, blue: 86/255.0, alpha: 1.0), day: "ciao4", month: "AGOSTO"),
        ]
    }
}
