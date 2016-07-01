//
//  File.swift
//  iMail
//
//  Created by Sumit Mukhija on 01/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import Foundation

class UserDefaultsManager: NSObject{
    
    let persistance = NSUserDefaults.standardUserDefaults()
    
    func storeAMail(mail: Email, key: String){
        let mailDictionary = ["mailSubject":mail.mailSubject, "mailId":mail.mailId, "mailParticipants":mail.peopleInvolved, "mailPreview": mail.mailPreview, "isMailRead":mail.isMailRead, "isMailStarred":mail.isMailStarred]
        persistance.setObject(mailDictionary, forKey: key)
        persistance.synchronize()
    }
    
//    func getAMail(key: String) -> Email{
//        //return Email()
//    }
    
    func getNumberOfEntries() -> Int{
        return persistance.dictionaryRepresentation().count
    }
    
    func removeAMail(mailId:Int){
        
    }
    
    
}