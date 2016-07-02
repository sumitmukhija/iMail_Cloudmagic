//
//  SearchResultViewController.swift
//  iMail
//
//  Created by Sumit Mukhija on 02/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class SearchResultViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    var dataSource: [Email] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = nil
        title = "Search Results"
        view.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
        navigationController?.navigationBar.backItem?.title = "All Mails"
        navigationController?.navigationBar.tintColor = AppColorTheme.whiteColor
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewControllerWithIdentifier("mailContentId") as!MailContentViewController
        detailViewController.concernedMail = dataSource[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchBoxItemId") as! InboxListItem
        cell.previewLabel.text = dataSource[indexPath.row].mailPreview
        cell.subjectLabel.text = dataSource[indexPath.row].mailSubject
        let peopleArray = dataSource[indexPath.row].peopleInvolved
        cell.senderLabel.text = peopleArray.joinWithSeparator(",")
        cell.starButton.enabled = false
        if dataSource[indexPath.row].isMailStarred{
            cell.starButton.setBackgroundImage(AppImages.starSelectedButtonImage, forState: .Normal)
        }
        else{
            cell.starButton.setBackgroundImage(AppImages.starUnselectedButtonImage, forState: .Normal)
        }
        if dataSource[indexPath.row].isMailRead{
            let font = UIFont(name: "Avenir-Book", size: 14.0)
            cell.senderLabel.font = font
        }
        else{
            let font = UIFont(name: "Avenir-Heavy", size: 17.0)
            cell.senderLabel.font = font
        }
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}