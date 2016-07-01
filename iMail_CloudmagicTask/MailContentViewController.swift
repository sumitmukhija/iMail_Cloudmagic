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
    let apiManager = APIManager()
    var mailBodyHeight: CGFloat = 0.0
    
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
    
    //MARK: Error alert
    func showErrorAlert(){
        let alert = UIAlertController(title: "Error!", message: "Looks like the email cannot be loaded. Please check your internet connection or try later.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cool!", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Delegates & data sources
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if concernedMail != nil{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCellWithIdentifier("mailHeaderCellId") as! FirstRowViewForMailContent
                cell.contentView.userInteractionEnabled = false
                if (concernedMail!.isMailStarred == true){
                    cell.starButton.setBackgroundImage(AppImages.starSelectedButtonImage, forState: .Normal)
                }
                else{
                    cell.starButton.setBackgroundImage(AppImages.starUnselectedButtonImage, forState: .Normal)
                }
                let nameOne = concernedMail!.peopleInvolved[0]
                cell.initialLabel.text = "\(nameOne.characters.first!)"
                cell.subjectLabel.text = concernedMail?.mailSubject
                cell.participantsLabel.text = concernedMail?.peopleInvolved.joinWithSeparator(",")
                cell.backgroundColor = UIColor.clearColor()
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clearColor()
                cell.selectedBackgroundView = bgColorView
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCellWithIdentifier("mailContentCellId") as! SecondRowForMailContent
                apiManager.getEmailBodyData((concernedMail?.mailId)!, completion: { (emailBody) in
                    cell.mailBody.text = emailBody
                    cell.contentView.userInteractionEnabled = false
                    self.mailBodyHeight = self.heightNeededForText(emailBody, withFont: UIFont.systemFontOfSize(20.0), width:tableView.frame.size.width, lineBreakMode: NSLineBreakMode.ByWordWrapping)
                    tableView.reloadData()
                    tableView.setNeedsLayout()
                })
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clearColor()
                cell.selectedBackgroundView = bgColorView
                return cell
            }
        }
        else{
            showErrorAlert()
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 120
        }
        else{
            return mailBodyHeight
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func heightNeededForText(text: NSString, withFont font: UIFont, width: CGFloat, lineBreakMode:NSLineBreakMode) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        let size: CGSize = text.boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: [ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle], context: nil).size
        return ceil(size.height);
    }
    
}
