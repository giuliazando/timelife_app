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
    // MARK: - Public API
    //var title = ""
    var ImageView: UIImage
    var color: UIColor
    var day: String
    
    
    init(ImageView: UIImage, color: UIColor, day: String)
    {
        //self.title = title
        self.ImageView = ImageView
        self.color = color
        self.day = day
    }
    
    // MARK: - Private
    // dummy data
    static func fetchInterests() -> [Interest]
    {
    return [
        Interest(ImageView: UIImage(named: "f1")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f2")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f3")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f4")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f5")!, color: UIColor(red: 245/255.0, green: 62/255.0, blue: 40/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f6")!, color: UIColor(red: 103/255.0, green: 217/255.0, blue: 87/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f7")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8), day: "ciao"),
            Interest(ImageView: UIImage(named: "f8")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8), day: "ciao4"),
        ]
    }
}

