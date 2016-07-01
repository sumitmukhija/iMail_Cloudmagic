//
//  FirstRowViewForMailContent.swift
//  iMail
//
//  Created by Sumit Mukhija on 01/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class FirstRowViewForMailContent:UITableViewCell{
    @IBOutlet var initalView: UIView!
    @IBOutlet var initialImageView: UIImageView!
    @IBOutlet var participantsLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet var initialLabel: UILabel!
    
    @IBAction func starButtonClicked(sender: UIButton) {
        if starButton.backgroundImageForState(.Normal) == AppImages.starSelectedButtonImage{
            starButton.setBackgroundImage(AppImages.starUnselectedButtonImage, forState: .Normal)
        }
        else{
            starButton.setBackgroundImage(AppImages.starSelectedButtonImage, forState: .Normal)
        }
    }
    
    
    override func awakeFromNib() {
        self.initalView.backgroundColor = AppColorTheme.themePrimaryColor
        self.initalView.layer.cornerRadius = 40;
        self.initalView.layer.borderWidth = 4
        self.initalView.layer.borderColor = AppColorTheme.whiteColor.CGColor
        
        //TODO: Since we don't have images, not implementing the images part..
        
        /*
         initialImageView.backgroundColor = AppColorTheme.themePrimaryColor
         initialImageView.layer.cornerRadius = 40;
         initialImageView.layer.borderWidth = 2
         initialImageView.layer.borderColor = AppColorTheme.whiteColor.CGColor
         */
    }
}