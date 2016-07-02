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
    let userDefaultsManager = UserDefaultsManager()

    //MARK: Data source
    var sectionArray = ["The ones you starred","Fresh arrivals","Already read them!"]
    var emailListArray:[Email] = []
    var readMailArray:[Email] = []
    var unreadMailArray:[Email] = []
    var starredMailArray:[Email] = []

    @IBOutlet weak var emptyView: UIView!
    var loadingView:UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setVisuals()
        setNavigationBarButtons()
    }

    override func viewWillAppear(animated: Bool) {
        fetchInboxListUsingAPICall()
    }

    func fetchInboxListUsingAPICall(){
        showLoadingScreen()
        flushAllArrays()
        apiManager.getInboxListData { (emailArray) in

            for element in emailArray{
                let email = element as! Email
                self.userDefaultsManager.storeAMail(email , key: "mail\(email.mailId)")
            }
            self.emailListArray = emailArray as! [Email]
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
            self.hideLoadingScreen()
            self.tableView.reloadData()
        }
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
        border.frame = CGRectMake(0, searchTextField.frame.size.height - borderWidth, searchTextField.frame.size.width, borderWidth)
        border.borderWidth = borderWidth
        searchTextField.layer.addSublayer(border)
        searchTextField.layer.masksToBounds = true
        searchTextField.attributedPlaceholder = NSAttributedString(string:"look up for a participant..",
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


        infoButton.addTarget(self, action: "infoBarButtonTapped", forControlEvents: .TouchUpInside)
        refreshButton.addTarget(self, action:"refreshBarButtonTapped", forControlEvents: .TouchUpInside)
        searchButton.addTarget(self, action:"searchBarButtonTapped", forControlEvents: .TouchUpInside)

        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        let refreshBarButtonItem = UIBarButtonItem(customView: refreshButton)
        let sortBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.leftBarButtonItem = infoBarButtonItem;
        navigationItem.rightBarButtonItems = [refreshBarButtonItem, sortBarButtonItem]
    }

    func infoBarButtonTapped(){
        let alert = UIAlertController(title: "Disclaimer", message: "This app has been made for the Cloudmagic iOS dev task. . It is made using XCode 7.2. The app fetches data using npm from https://github.com/webyog/ios-dev-task. The images used in the project are taken either from iconfinder or random Google searches and I own no rights over them. I haven't used any third parties except Alamofire for the sake of simplicity. For any further queries, feel free to reach out at sumitmukhija@hotmail.com", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cool!", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func refreshBarButtonTapped(){
        fetchInboxListUsingAPICall()
    }

    func searchBarButtonTapped(){
        searchTextField.becomeFirstResponder()

    }

    //MARK: Loading screen methods
    func showLoadingScreen(){
        loadingView = NSBundle.mainBundle().loadNibNamed("LoadingScreen", owner: self, options: nil)[0] as! UIView
        loadingView.frame = self.view.frame
        navigationController?.view.addSubview(loadingView)
    }

    func hideLoadingScreen(){
        loadingView.removeFromSuperview()
    }

    //MARK: delegate & datasources
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldShouldClear(textField: UITextField) -> Bool {
        setupSearchedProductArrayWithSearchText("")
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let enteredString : NSString = textField.text!;
        let currentlySearchedText = enteredString.stringByReplacingCharactersInRange(range, withString: string).lowercaseString
        setupSearchedProductArrayWithSearchText(currentlySearchedText)
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
//            for mail in emailListArray{
//                if mail.isMailStarred{
//                    starredMailCount = starredMailCount + 1
//                }
//            }
//            return starredMailCount
        }
        else if section == 1{
//            var unreadMailCount = 0
//            for mail in emailListArray{
//                if(mail.isMailRead == false){
//                    unreadMailCount = unreadMailCount + 1
//                }
//            }
            return unreadMailArray.count
        }
        else if section == 2{
//            var readMailCount = 0
//            for mail in emailListArray{
//                if mail.isMailRead{
//                    readMailCount = readMailCount + 1
//                }
//            }
            return readMailArray.count
        }

        return 0
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            deleteMail(indexPath.row)
        }
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        //        let cellAnimation = CATransform3DTranslate(CATransform3DIdentity, -500, 10 , 90)
        //        cell.layer.transform = cellAnimation
        //        UIView.animateWithDuration(0.8) {
        //            cell.layer.transform = CATransform3DIdentity
        //        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inboxListItemId") as! InboxListItem
        cell.bringSubviewToFront(cell.starButton)
        cell.starButtonTappedClosure = {(starButton:UIButton) in
            if starButton.backgroundImageForState(.Normal) == AppImages.starSelectedButtonImage{
                starButton.setBackgroundImage(AppImages.starUnselectedButtonImage, forState: .Normal)
                self.emailListArray[indexPath.row].isMailStarred = false
            }
            else{
                starButton.setBackgroundImage(AppImages.starSelectedButtonImage, forState: .Normal)
                self.emailListArray[indexPath.row].isMailStarred = true
            }
        }
        var offset = 0
        if indexPath.section == 1{
            offset = offset + starredMailArray.count
        }
        if indexPath.section == 2{
            offset = offset + starredMailArray.count + unreadMailArray.count
        }
        let currentMail = emailListArray[indexPath.row + offset]
        cell.subjectLabel.text = currentMail.mailSubject
        cell.previewLabel.text = currentMail.mailPreview
        cell.senderLabel.text = currentMail.peopleInvolved.count == 2 ? currentMail.peopleInvolved.joinWithSeparator(" & "): currentMail.peopleInvolved.joinWithSeparator(",")
        let starImage = currentMail.isMailStarred ? AppImages.starSelectedButtonImage : AppImages.starUnselectedButtonImage
        cell.starButton.setBackgroundImage(starImage, forState: .Normal)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = bgColorView
        return cell
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let readUnreadToggleAction = UITableViewRowAction(style: .Normal, title: "unread\n/read") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            var currentMail = self.emailListArray[indexPath.row]
            if currentMail.isMailRead{
                currentMail.isMailRead = false
                self.unreadMailArray.append(currentMail)
                var i = 0
                for mail in self.readMailArray{
                    if mail.mailId == currentMail.mailId{
                        self.readMailArray.removeAtIndex(i)
                    }
                    i = i+1
                }
                self.emailListArray.removeAll()
                self.emailListArray = self.starredMailArray + self.unreadMailArray + self.readMailArray
                tableView.reloadData()
            }
            else{
                currentMail.isMailRead = true
                self.readMailArray.append(currentMail)
                var i = 0
                for mail in self.unreadMailArray{
                    if mail.mailId == currentMail.mailId{
                        self.unreadMailArray.removeAtIndex(i)
                        break
                    }
                    i = i+1
                }
                self.emailListArray.removeAll()
                self.emailListArray = self.starredMailArray + self.unreadMailArray + self.readMailArray
                tableView.reloadData()
            }
        }
        readUnreadToggleAction.backgroundColor = AppColorTheme.themePrimaryColor
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            self.deleteMail(indexPath.row)
        }
        deleteAction.backgroundColor = UIColor.redColor()

        return [readUnreadToggleAction,deleteAction]
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }

    func deleteMail(row: Int) -> Void {
        showLoadingScreen()
        let currentMail = emailListArray[row]
        apiManager.deleteMail(currentMail.mailId, completion: { (success) in
            self.hideLoadingScreen()
            if success == true
            {
                let alert = UIAlertController(title: "Deleted!", message: "The selected email(s) was/were deleted successfully.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Cannot delete", message: "The selected email(s) wasn't/weren't deleted.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }})
        tableView.reloadData()
    }

    func setupSearchedProductArrayWithSearchText(searchedText : String)
    {

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
    var starButtonTappedClosure:((UIButton)->())!


    @IBAction func starButtonTapped(sender: UIButton) {
        starButtonTappedClosure(sender)
    }
    override func awakeFromNib() {
        containerView.layer.cornerRadius = 4
    }
}