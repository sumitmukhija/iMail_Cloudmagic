//
//  LoadingScreen.swift
//  iMail
//
//  Created by Sumit Mukhija on 30/06/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit
import Foundation


class LoadingScreen: UIView {
    @IBOutlet weak var emailImage: UIImageView!
    override func awakeFromNib() {
        scaleUp()
    }
    
    func scaleUp(){
        UIView.animateWithDuration(0.35, animations: {
            self.emailImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        }) { (success) in
            self.scaleDown()
        }

    }
    
    func scaleDown(){
        UIView.animateWithDuration(0.35, animations: {
            self.emailImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
        }) { (success) in
            self.scaleUp()
        }
    }
}
