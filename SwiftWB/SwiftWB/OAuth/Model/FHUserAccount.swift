//
//  FHUserAccount.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-12.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHUserAccount: NSObject, NSCoding {
    
    var expires_in : String?
    var remind_in : String?
    var access_token : String?
    var uid : String?
    
    /// 重写description 方法
    override var description: String
    {
        return dictionaryWithValues(forKeys: ["expires_in","remind_in","access_token","access_token"]).description
    }
 
    /// 还没弄清楚
    override init()
    {
        super.init()
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(remind_in, forKey: "remind_in")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.expires_in = aDecoder.decodeObject(forKey: "expires_in") as? String
        self.remind_in = aDecoder.decodeObject(forKey: "remind_in") as? String
        self.access_token =  aDecoder.decodeObject(forKey: "access_token")as? String
        self.uid = aDecoder.decodeObject(forKey: "uid")as? String
    }
}

