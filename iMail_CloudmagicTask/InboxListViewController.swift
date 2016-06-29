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

