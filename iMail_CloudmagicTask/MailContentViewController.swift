//
//  MailContentViewController.swift
//  iMail_CloudmagicTask
//
//  Created by Sumit Mukhija on 29/06/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import Foundation
import UIKit

class MailContentViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var contactsThumbnailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewVisuals()
    }
    
    //MARK: Setting visuals
    func setViewVisuals(){
        view.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
        navigationController?.navigationBar.tintColor = AppColorTheme.whiteColor
        contactsThumbnailTableView.separatorStyle = .None
        contactsThumbnailTableView.backgroundView = nil
        contactsThumbnailTableView.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
    }
    
    //MARK: Delegates & data sources
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ContactThumbnailTableViewCell
        cell.initialCharacterLabel.textColor = AppColorTheme.themePrimaryColor
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ContactThumbnailTableViewCell
        cell.initialCharacterLabel.textColor = AppColorTheme.whiteColor
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactThumbnailCellId") as! ContactThumbnailTableViewCell
        cell.initialCharacterLabel.text = "S"
        let backgroundView = UIView()
        backgroundView.backgroundColor = AppColorTheme.whiteColor
        cell.selectedBackgroundView = backgroundView
        let randomColor = UIColor(red: CGFloat(arc4random()) / CGFloat(UInt32.max), green: CGFloat(arc4random()) / CGFloat(UInt32.max), blue: CGFloat(arc4random()) / CGFloat(UInt32.max), alpha: 1.0)
        cell.backgroundColor = AppColorTheme.themePrimaryColor
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
}

class ContactThumbnailTableViewCell: UITableViewCell{
    @IBOutlet weak var initialCharacterLabel: UILabel!
    
}
