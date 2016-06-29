//
//  ViewController.swift
//  iMail_CloudmagicTask
// 
//  Created by Sumit Mukhija on 29/06/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class InboxListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVisuals()
        setNavigationBarButtons()
    }
    
    func setVisuals(){
        setViewVisualAttributes()
        setNavigationVisualttributes()
    }
    
    func setViewVisualAttributes(){
        self.title = "Inbox"
        self.view.backgroundColor = AppColorTheme.primaryBackgroundColor
    }
    
    func setNavigationVisualttributes(){
        self.navigationController?.navigationBar.barTintColor = AppColorTheme.themePrimaryColor;
       self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
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
        
        self.navigationItem.leftBarButtonItem = infoBarButtonItem;
        self.navigationItem.rightBarButtonItems = [refreshBarButtonItem, sortBarButtonItem]
    
    }
    
    func infoBarButtonTapped(){
        
    }
    
    func refreshBarButtonTapped(){
        
    }
    
    func sortBarButtonTapped(){
        
    }
    
//    -(void)setNavigationVisualProperties{
//    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    UIImage *image = [UIImage imageNamed:@"reload"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
//    [button setImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(refreshPressed:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *refreshBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIImage *infoImage = [UIImage imageNamed:@"info"];
//    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    infoButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
//    [infoButton setImage:infoImage forState:UIControlStateNormal];
//    [infoButton addTarget:self action:@selector(infoPressed:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *infoBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
//    
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
//    self.title = @"Top News";
//    self.navigationItem.rightBarButtonItem = refreshBarButtonItem;
//    self.navigationItem.leftBarButtonItem = infoBarButtonItem;
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

