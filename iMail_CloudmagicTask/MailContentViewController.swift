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
    
    var concernedMail:Email?=nil
    @IBOutlet weak var mailBodyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewVisuals()
    }
    
    //MARK: Setting visuals
    func setViewVisuals(){
        view.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
        navigationController?.navigationBar.tintColor = AppColorTheme.whiteColor
        mailBodyTableView.separatorStyle = .None
        mailBodyTableView.backgroundView = nil
        mailBodyTableView.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
        mailBodyTableView.registerNib((UINib(nibName: "FirstRowViewForMailContent", bundle: nil)), forCellReuseIdentifier:"mailHeaderCellId")
        mailBodyTableView.registerNib(UINib(nibName: "SecondRowForMailContent", bundle: nil), forCellReuseIdentifier: "mailContentCellId")
    }
    
    
    
    //MARK: Delegates & data sources
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("mailHeaderCellId") as! FirstRowViewForMailContent
            let nameOne = concernedMail!.peopleInvolved[0]
            cell.initialLabel.text = "\(nameOne.characters.first!)"
            cell.subjectLabel.text = concernedMail?.mailSubject
            cell.participantsLabel.text = concernedMail?.peopleInvolved.joinWithSeparator(",")
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("mailContentCellId") as! SecondRowForMailContent
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == 0
        {
            return 120
        }
        else{
            return 200
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
}
