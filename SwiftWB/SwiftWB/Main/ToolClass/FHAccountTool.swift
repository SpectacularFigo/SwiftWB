//
//  FHAccountTool.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-03-15.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHAccountTool: NSObject {

    class func accessToken() ->String?
    {
         let searchPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("account.plist")
        
         let userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: searchPath) as? FHUserAccount
        
         let access_token = userAccount?.access_token
        
         return access_token
    }
    
}
