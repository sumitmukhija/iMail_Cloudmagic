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
        fetchInboxListUsingAPICall();
    }
    
    func fetchInboxListUsingAPICall(){
        showLoadingScreen()
        apiManager.getInboxListData { (emailArray) in
            self.emailListArray = emailArray as! [Email]
            self.hideLoadingScreen()
            self.tableView.reloadData()
        }
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
        let sortButton = UIButton(type: .Custom)
        infoButton.bounds = CGRectMake( 0, 0, AppImages.infoBarButtonImage!.size.width, AppImages.infoBarButtonImage!.size.height)
        refreshButton.bounds = CGRectMake( 0, 0, AppImages.refreshBarButtonImage!.size.width, AppImages.refreshBarButtonImage!.size.height)
        sortButton.bounds = CGRectMake( 0, 0, AppImages.sortBarButtonImage!.size.width, AppImages.sortBarButtonImage!.size.height)
        infoButton.setImage(AppImages.infoBarButtonImage, forState: .Normal)
        refreshButton.setImage(AppImages.refreshBarButtonImage, forState: .Normal)
        sortButton.setImage(AppImages.sortBarButtonImage, forState: .Normal)
        
        
        infoButton.addTarget(self, action: "infoBarButtonTapped", forControlEvents: .TouchUpInside)
        refreshButton.addTarget(self, action:"refreshBarButtonTapped", forControlEvents: .TouchUpInside)
        sortButton.addTarget(self, action:"sortBarButtonTapped", forControlEvents: .TouchUpInside)
        
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        let refreshBarButtonItem = UIBarButtonItem(customView: refreshButton)
        let sortBarButtonItem = UIBarButtonItem(customView: sortButton)
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
    
    func sortBarButtonTapped(){
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewControllerWithIdentifier("mailContentId")
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
                var starredMailCount = 0
                for mail in emailListArray{
                    if mail.isMailStarred{
                        starredMailCount = starredMailCount + 1
                    }
                }
                return starredMailCount
            }
            else if section == 1{
                var readMailCount = 0
                for mail in emailListArray{
                    if mail.isMailRead{
                        readMailCount = readMailCount + 1
                    }
                }
                return readMailCount
            }
            else if section == 2{
                var unreadMailCount = 0
                for mail in emailListArray{
                    if(mail.isMailRead == false){
                        unreadMailCount = unreadMailCount + 1
                    }
                }
                return unreadMailCount
            }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        let cellAnimation = CATransform3DTranslate(CATransform3DIdentity, -500, 10 , 90)
        cell.layer.transform = cellAnimation
        UIView.animateWithDuration(0.8) {
            cell.layer.transform = CATransform3DIdentity
        }
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