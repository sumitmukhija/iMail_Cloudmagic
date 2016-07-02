//
//  AlertManager.swift
//  iMail
//
//  Created by Sumit Mukhija on 02/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit
import Foundation

class AlertManager:NSObject{

    class func getAlert(title: String, body: String, cancelButton:String) -> AnyObject{
        let alert = UIAlertController(title: title , message:body, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: cancelButton, style: .Default, handler: nil))
        return alert
    }

}