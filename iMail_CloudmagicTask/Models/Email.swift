//
//  Email.swift
//  iMail
//
//  Created by Sumit Mukhija on 01/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import Foundation

class Email: NSObject{
    var mailId:Int
    var isMailRead:Bool
    {
        didSet(oldValue)
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(isMailRead, forKey: "isReadForId\(mailId)")
            defaults.synchronize()
        }
    }
    var isMailStarred:Bool
    {
        didSet(oldValue){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(isMailStarred, forKey: "isStarredForId\(mailId)")
            defaults.synchronize()
        }
    }
    var peopleInvolved:[String]
    var mailPreview:String
    var mailSubject:String
    var body:String?
    
    init(dataDictionary : [String : AnyObject]) {
        mailId = dataDictionary["id"] as! Int
        isMailRead = dataDictionary["isRead"] as! Bool
        isMailStarred = dataDictionary["isStarred"] as! Bool
        peopleInvolved = dataDictionary["participants"] as! [String]
        mailPreview = dataDictionary["preview"] as! String
        mailSubject = dataDictionary["subject"] as! String

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(isMailRead, forKey: "isReadForId\(mailId)")
        defaults.setBool(isMailStarred, forKey: "isStarredForId\(mailId)")
        defaults.synchronize()

    }
}
