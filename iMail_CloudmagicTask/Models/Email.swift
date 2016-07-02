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
            print("\(isMailRead) read for isReadForId\(mailId)")
            defaults.synchronize()
        }
    }
    var isMailStarred:Bool
    {
        didSet(oldValue){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(isMailStarred, forKey: "isStarredForId\(mailId)")
            print("\(isMailStarred) read for isStarredForId\(mailId)")
            defaults.synchronize()
        }
    }
    var peopleInvolved:[String]
    var mailPreview:String
    var mailSubject:String
    var body:String?
    
    init(dataDictionary : [String : AnyObject]) {
        isMailRead = false
        isMailStarred = false
        mailId = dataDictionary["id"] as! Int
        peopleInvolved = dataDictionary["participants"] as! [String]
        mailPreview = dataDictionary["preview"] as! String
        mailSubject = dataDictionary["subject"] as! String

        let defaults = NSUserDefaults.standardUserDefaults()

        if (defaults.objectForKey("isReadForId\(mailId)") == nil){
             isMailRead = dataDictionary["isRead"] as! Bool
        }
        else{
            isMailRead = defaults.boolForKey("isReadForId\(mailId)")
        }

        if (defaults.objectForKey("isStarredForId\(mailId)") == nil){
             isMailStarred = dataDictionary["isStarred"] as! Bool
        }
        else{
            isMailStarred = defaults.boolForKey("isStarredForId\(mailId)")
        }
        defaults.setBool(isMailRead, forKey: "isReadForId\(mailId)")
        defaults.setBool(isMailStarred, forKey: "isStarredForId\(mailId)")
        defaults.synchronize()

    }
}
