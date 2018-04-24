//
//  CollectionViewCell.swift
//  Timelife
//
//  Created by Giulia Zandonà on 27/03/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var BackgroundColorView: UIView!
    @IBOutlet weak var MonthDay: UILabel!
    @IBOutlet weak var MonthName: UILabel!
    

    var interest: Interest?{
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let interest = interest {
            ImageView.image = interest.ImageView
            BackgroundColorView.backgroundColor = interest.color
            //MonthDay.text = interest.title
            //MonthName.text = interest.title
        } else {
            ImageView.image = nil
            BackgroundColorView.backgroundColor = nil
            //MonthDay.text = nil
            //MonthName.text = nil
        }
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
    
   @IBOutlet weak var image: UIImageView!
   @IBOutlet weak var photoTitle: UILabel!
   @IBOutlet weak var photoText: UILabel!
    
}


    

