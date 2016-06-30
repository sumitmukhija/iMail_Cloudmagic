//
//  ViewController.swift
//  iMail_CloudmagicTask
// 
//  Created by Sumit Mukhija on 29/06/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class InboxListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setVisuals()
        setNavigationBarButtons()
    }
    
    //MARK: Setting visual properties
    func setVisuals(){
        setViewVisualAttributes()
        setNavigationVisualttributes()
        setSearchTextFieldAttributes()
    }
    
    func setViewVisualAttributes(){
        title = "Inbox"
        tableView.separatorStyle = .None
        view.backgroundColor = AppColorTheme.whiteColor
    }
    
    func setSearchTextFieldAttributes(){
        let border = CALayer()
        let borderWidth:CGFloat = 2.0;
        border.borderColor = AppColorTheme.whiteColor.CGColor
        border.frame = CGRectMake(0, searchTextField.frame.size.height - borderWidth, searchTextField.frame.size.width, searchTextField.frame.size.height)
        border.borderWidth = borderWidth
        searchTextField.layer.addSublayer(border)
        searchTextField.layer.masksToBounds = true
        searchTextField.attributedPlaceholder = NSAttributedString(string:"look up for a participant..",
                                                               attributes:[NSForegroundColorAttributeName: AppColorTheme.whiteColor])
    }
    
    func setNavigationVisualttributes(){
        navigationController?.navigationBar.barTintColor = AppColorTheme.themePrimaryColor;
       navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.translucent = false
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: Navigation bar buttons & their actions
    func setNavigationBarButtons(){
        let infoButton = UIButton(type: .Custom)
        let refreshButton = UIButton(type: .Custom)
        let sortButton = UIButton(type: .Custom)
        infoButton.bounds = CGRectMake( 0, 0, AppImages.infoBarButtonImage!.size.width, AppImages.infoBarButtonImage!.size.height)
        refreshButton.bounds = CGRectMake( 0, 0, AppImages.refreshBarButtonImage!.size.width, AppImages.refreshBarButtonImage!.size.height)
        sortButton.bounds = CGRectMake( 0, 0, AppImages.sortBarButtonImage!.size.width, AppImages.sortBarButtonImage!.size.height)
        infoButton.setImage(AppImages.infoBarButtonImage, forState: .Normal)
        refreshButton.setImage(AppImages.refreshBarButtonImage, forState: .Normal)
        sortButton.setImage(AppImages.sortBarButtonImage, forState: .Normal)
        infoButton.addTarget(self, action: #selector(InboxListViewController.infoBarButtonTapped), forControlEvents: .TouchUpInside)
        refreshButton.addTarget(self, action: #selector(InboxListViewController.refreshBarButtonTapped), forControlEvents: .TouchUpInside)
        sortButton.addTarget(self, action: #selector(InboxListViewController.sortBarButtonTapped), forControlEvents: .TouchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        let refreshBarButtonItem = UIBarButtonItem(customView: refreshButton)
        let sortBarButtonItem = UIBarButtonItem(customView: sortButton)
        navigationItem.leftBarButtonItem = infoBarButtonItem;
        navigationItem.rightBarButtonItems = [refreshBarButtonItem, sortBarButtonItem]
    }
    
    func infoBarButtonTapped(){
        
    }
    
    func refreshBarButtonTapped(){
        
    }
    
    func sortBarButtonTapped(){
        
    }
    
    //MARK: delegate & datasources
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inboxListItemId") as! InboxListItem
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class InboxListItem: UITableViewCell{
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    override func awakeFromNib() {
        containerView.layer.cornerRadius = 4
    }
}

