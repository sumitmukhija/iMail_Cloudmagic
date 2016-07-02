//
//  TutorialView.swift
//  iMail
//
//  Created by Deepak on 02/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class TutorialView: UIView{

    @IBOutlet weak var primaryImage: UIImageView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var helpLabel: UILabel!
    var i = 0
    var swipeGesture: UISwipeGestureRecognizer!
    let tutorialImages = [AppImages.tutorialOneImage, AppImages.tutorialTwoImage, AppImages.tutorialThreeImage]
    let tutorialTexts = ["Your mail is categorised as starred, unread & read. Swipe from right to left for next tutorial", "You can search directly by tapping on the search bar or the search button", "You can delete or mark a mail as read/unread by swiping it from right to left"]

    override func awakeFromNib() {
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(TutorialView.swiped(_:)))
        swipeGesture.direction = .Left
        self.addGestureRecognizer(swipeGesture)
        setSkipAttribs()
    }

    func swiped(gesture: UISwipeGestureRecognizer){
        if i != tutorialImages.count{
            setTutorialAtIndex(i)
            if gesture.direction == .Left{
                i = i + 1
            }
        }
        else{
            self.removeFromSuperview()
        }

    }

    func setTutorialAtIndex(i: Int){
        primaryImage.image = tutorialImages[i]
        helpLabel.text = tutorialTexts[i]
    }

    func showImage(timer:NSTimer) {
        self.primaryImage.image = tutorialImages[i]
        self.helpLabel.text = tutorialTexts[i]
        i = i+1

    }

    func setSkipAttribs(){
        skipButton.layer.cornerRadius = 2
        skipButton.layer.borderColor = AppColorTheme.whiteColor.CGColor
        skipButton.layer.borderWidth = 2
    }

    @IBAction func skipPressed(sender: AnyObject) {
        self.removeFromSuperview()
    }

}