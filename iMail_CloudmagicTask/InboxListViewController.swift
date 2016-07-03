//
//  ViewController.swift
//  iMail_CloudmagicTask
//
//  Created by Sumit Mukhija on 29/06/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class InboxListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let apiManager = APIManager()

    //MARK: Data source
    var sectionArray = ["The ones you starred","Fresh arrivals","Already read them!"]
    var emailListArray:[Email] = []
    var readMailArray:[Email] = []
    var unreadMailArray:[Email] = []
    var starredMailArray:[Email] = []

    @IBOutlet weak var emptyView: UIView!
    var loadingView:LoadingScreen!
    var tutorialView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setVisuals()
        setNavigationBarButtons()
    }

    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().boolForKey("areTutorialsShown") != true{
            showTutorials()
        }
        fetchInboxFromServer()
    }

    func fetchInboxFromServer(){
        showLoadingScreen()
        flushAllArrays()
        apiManager.getInboxListData { (emailArray) in
            self.recreateArrayWithAPIArray(emailArray as! [Email])
            self.hideLoadingScreen()
            self.tableView.reloadData()
        }
    }

    func recreateArrayWithAPIArray(emailArray: [Email]){
         self.emailListArray = emailArray
        for mail in self.emailListArray{
            if mail.isMailStarred{
                self.starredMailArray.append(mail)
            }
            else{
                if mail.isMailRead == true
                {
                    self.readMailArray.append(mail)
                }
                else{
                    self.unreadMailArray.append(mail)
                }
            }

        }
        self.generateEmailArray()
    }


    func flushAllArrays(){
        emailListArray.removeAll()
        starredMailArray.removeAll()
        unreadMailArray.removeAll()
        readMailArray.removeAll()
    }

    func generateEmailArray(){
        self.emailListArray = self.starredMailArray + self.unreadMailArray + self.readMailArray
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
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clearColor()
        view.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
        emptyView.hidden = true
    }

    func setSearchTextFieldAttributes(){
        let border = CALayer()
        let borderWidth:CGFloat = 1.0;
        border.borderColor = AppColorTheme.whiteColor.CGColor
        border.frame = CGRectMake(searchTextField.frame.origin.x, searchTextField.frame.size.height - borderWidth, searchTextField.frame.size.width, borderWidth)
        border.borderWidth = borderWidth
        searchTextField.layer.addSublayer(border)
        searchTextField.layer.masksToBounds = true
        searchTextField.attributedPlaceholder = NSAttributedString(string:"Look up for a participant..",
                                                                   attributes:[NSForegroundColorAttributeName: AppColorTheme.themePrimaryBackgroundColor])
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
        let searchButton = UIButton(type: .Custom)
        infoButton.bounds = CGRectMake( 0, 0, AppImages.infoBarButtonImage!.size.width, AppImages.infoBarButtonImage!.size.height)
        refreshButton.bounds = CGRectMake( 0, 0, AppImages.refreshBarButtonImage!.size.width, AppImages.refreshBarButtonImage!.size.height)
        searchButton.bounds = CGRectMake( 0, 0, AppImages.searchBarButtonImage!.size.width, AppImages.searchBarButtonImage!.size.height)
        infoButton.setImage(AppImages.infoBarButtonImage, forState: .Normal)
        refreshButton.setImage(AppImages.refreshBarButtonImage, forState: .Normal)
        searchButton.setImage(AppImages.searchBarButtonImage, forState: .Normal)


        infoButton.addTarget(self, action: #selector(InboxListViewController.infoBarButtonTapped), forControlEvents: .TouchUpInside)
        refreshButton.addTarget(self, action:#selector(InboxListViewController.refreshBarButtonTapped), forControlEvents: .TouchUpInside)
        searchButton.addTarget(self, action:#selector(InboxListViewController.searchBarButtonTapped), forControlEvents: .TouchUpInside)

        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        let refreshBarButtonItem = UIBarButtonItem(customView: refreshButton)
        let sortBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.leftBarButtonItem = infoBarButtonItem;
        navigationItem.rightBarButtonItems = [refreshBarButtonItem, sortBarButtonItem]
    }

    func infoBarButtonTapped(){

        let alert = AlertManager.getAlert("Disclaimer", body: "This app has been made for the Cloudmagic iOS dev task. . It is made using XCode 7.3. The app fetches data using npm from https://github.com/webyog/ios-dev-task. The images used in the project are taken either from iconfinder or random Google searches and I own no rights over them. I haven't used any third parties except Alamofire for the sake of simplicity. For any further queries, feel free to reach out at sumitmukhija@hotmail.com", cancelButton: "Cool!") as! UIAlertController
        alert.addAction(UIAlertAction(title: "Show Tutorials", style: .Destructive, handler: { (action) in
            self.showTutorials()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func refreshBarButtonTapped(){
        fetchInboxFromServer()
    }

    func searchBarButtonTapped(){
        searchTextField.becomeFirstResponder()

    }

    //MARK: Loading screen methods
    func showLoadingScreen(){
        loadingView = NSBundle.mainBundle().loadNibNamed("LoadingScreen", owner: self, options: nil)[0] as! LoadingScreen
        loadingView.takingTooLongClosure = {()in
            let alert = AlertManager.getAlert("Hold your horses..or don't!", body: "The app currently works on a local server. Make sure, your localhost is up and running. If everything looks fine, try executing it again.", cancelButton: "Okay")
            self.presentViewController(alert as! UIViewController, animated: true, completion: nil)
        }
        loadingView.frame = self.view.frame
        navigationController?.view.addSubview(loadingView)
    }

    func hideLoadingScreen(){
        loadingView.removeFromSuperview()
    }

    //MARK: Tutorial screen
    func showTutorials(){
        tutorialView = NSBundle.mainBundle().loadNibNamed("TutorialView", owner: self, options: nil)[0] as! UIView
        tutorialView.frame = self.view.frame
        navigationController?.view.addSubview(tutorialView)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "areTutorialsShown")
    }

    //MARK: delegate & datasources
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        var searchResultArray:[Email] = []
        let queryString = searchTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        if queryString.characters.count == 0 || emailListArray.count == 0{
            return false
        }
        for mail in emailListArray{
            for person in mail.peopleInvolved{
                if person.lowercaseString == queryString.lowercaseString{
                    if searchResultArray.contains(mail) == false{
                        searchResultArray.append(mail)
                    }
                }
            }
        }
        if searchResultArray.count == 0{
           let alert =  AlertManager.getAlert("Oops!", body: "Looks like the participant you were searching for hasn't mailed you, YET!", cancelButton: "Okay")
            presentViewController(alert as! UIViewController, animated: true, completion: nil)
        }
        else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let searchViewController = storyBoard.instantiateViewControllerWithIdentifier("searchResults") as! SearchResultViewController
            searchViewController.dataSource = searchResultArray
            navigationController?.pushViewController(searchViewController, animated: true)
        }
        return true
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewControllerWithIdentifier("mailContentId") as!MailContentViewController
        var offset = 0
        if indexPath.section == 1{
            offset = offset + starredMailArray.count
        }
        if indexPath.section == 2{
            offset = offset + starredMailArray.count + unreadMailArray.count
        }
        let currentMail = emailListArray[indexPath.row + offset]
        currentMail.isMailRead = true
        detailViewController.concernedMail = currentMail
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionArray.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerBackView = UIView()
        headerBackView.backgroundColor = AppColorTheme.themePrimaryBackgroundColor
        let headerLabel = UILabel(frame: CGRectMake(0,0,view.frame.size.width,60))
        headerLabel.font = UIFont(name: "Avenir-Light", size: 15.0)
        headerLabel.backgroundColor = UIColor.clearColor()
        headerLabel.textAlignment = .Center
        headerLabel.textColor = UIColor.lightGrayColor()
        headerLabel.text = sectionArray[section]
        headerBackView .addSubview(headerLabel)
        return headerBackView;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return starredMailArray.count
        }
        else if section == 1{
            return unreadMailArray.count
        }
        else if section == 2{
            return readMailArray.count
        }
        return 0
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inboxListItemId") as! InboxListItem
        cell.bringSubviewToFront(cell.starButton)
        var offset = 0
        if indexPath.section == 1{
            offset = offset + starredMailArray.count
        }
        if indexPath.section == 2{
            offset = offset + starredMailArray.count + unreadMailArray.count
        }
        var currentMail = emailListArray[indexPath.row + offset]
        cell.starButtonTapAction = {(starButton:UIButton) in
            if starButton.backgroundImageForState(.Normal) == AppImages.starSelectedButtonImage{
                starButton.setBackgroundImage(AppImages.starUnselectedButtonImage, forState: .Normal)
                currentMail.isMailStarred = false
            }
            else{
                starButton.setBackgroundImage(AppImages.starSelectedButtonImage, forState: .Normal)
                currentMail.isMailStarred = true
            }
            self.viewWillAppear(true)
        }
        cell.subjectLabel.text = currentMail.mailSubject
        cell.subjectLabel.textColor = AppColorTheme.themePrimaryColor
        cell.previewLabel.text = currentMail.mailPreview
        let senderString = currentMail.peopleInvolved.count == 2 ? currentMail.peopleInvolved.joinWithSeparator(" & "): currentMail.peopleInvolved.joinWithSeparator(",")
        if currentMail.isMailRead == false{
            let font = UIFont(name: "Avenir-Heavy", size: 17.0)
            cell.senderLabel.font = font
        }
        else{
             let font = UIFont(name: "Avenir-Book", size: 14.0)
            cell.senderLabel.font = font
        }
        cell.senderLabel.text = senderString

        let starImage = currentMail.isMailStarred ? AppImages.starSelectedButtonImage : AppImages.starUnselectedButtonImage
        cell.starButton.setBackgroundImage(starImage, forState: .Normal)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = bgColorView
        return cell
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let readUnreadToggleAction = UITableViewRowAction(style: .Normal, title: "Read\n/Unread") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            var offset = 0
            if indexPath.section == 1{
                offset = offset + self.starredMailArray.count
            }
            if indexPath.section == 2{
                offset = offset + self.starredMailArray.count + self.unreadMailArray.count
            }
            var currentMail = self.emailListArray[indexPath.row + offset]
            if currentMail.isMailRead{
                currentMail.isMailRead = false
            }
            else{
                currentMail.isMailRead = true
            }
            self.viewWillAppear(true)
        }
        readUnreadToggleAction.backgroundColor = AppColorTheme.themePrimaryColor
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            var offset = 0
            if indexPath.section == 1{
                offset = offset + self.starredMailArray.count
            }
            if indexPath.section == 2{
                offset = offset + self.starredMailArray.count + self.unreadMailArray.count
            }
            var currentMail = self.emailListArray[indexPath.row + offset]
            self.deleteMail(currentMail)
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [readUnreadToggleAction,deleteAction]
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }

    func deleteMail(mail: Email) -> Void {
        apiManager.deleteMail(mail.mailId, completion: { (success) in
            if success == true
            {
                let alert = AlertManager.getAlert("Success!", body: "The selected email was deleted successfully", cancelButton: "Okay")
                self.presentViewController(alert as! UIViewController, animated: true, completion: nil)
            }
            else
            {
                let alert = AlertManager.getAlert("Failure!", body: "The selected email wasn't deleted", cancelButton: "Okay")
                self.presentViewController(alert as! UIViewController, animated: true, completion: nil)
            }})
        self.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}