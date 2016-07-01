//
//  APIManager.swift
//  iMail
//
//  Created by Sumit Mukhija on 30/06/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import Foundation
import Alamofire

class APIManager{

    func getInboxListData(completion:(NSArray)->Void){
        Alamofire.request(.GET, "http://127.0.0.1:8088/api/message/", parameters:nil)
            .responseJSON { response in
                if let json = response.result.value{
                    let auxArray:NSMutableArray = []
                    for mailObject in (json as! NSArray){
                        auxArray.addObject(Email(dataDictionary: mailObject as![String : AnyObject]))
                    }
                    print(json)
                    completion(auxArray)
                }
        }
    }
    
    func getEmailBodyData(emailId: Int, completion: (String)-> Void){
        Alamofire.request(.GET, "http://127.0.0.1:8088/api/message/\(emailId)", parameters:nil)
            .responseJSON { response in
                if let json = response.result.value{
                    let dataDictionary = json as! NSDictionary
                    let mailBody:String = dataDictionary["body"] as! String
                    completion(mailBody)
                }
        }

    }
    
    func deleteMail(emailId: Int, completion: (Bool)->Void){
        Alamofire.request(.DELETE, "http://127.0.0.1:8088/api/message/\(emailId)", parameters:nil)
            .responseJSON { response in
                if let json = response.result.value{
                    print(json)
                    completion(true)
                }
                else{
                    completion(false)
                }
        }
    }
    
}