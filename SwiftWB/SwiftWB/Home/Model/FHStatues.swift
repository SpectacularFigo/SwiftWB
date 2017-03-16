//
//  FHStatues.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-16.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHStatues: NSObject {

    
    // MARK:- properties
    var created_at: String?
    var idstr: String?
    var text: String?
    var source: String?
    var user : FHUser?
    var pic_urls : [[String : String]]?
    var retweeted_status : FHStatues?
    
    
    // MARK:- initializers and KVC
    
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
        if let user = dict["user"] as? [String : AnyObject]{
            self.user = FHUser.init(dict: user)
        }
        
        if let retweeted_status = dict["retweeted_status"] as? [String : AnyObject] {
            self.retweeted_status = FHStatues.init(dict: retweeted_status)
        }
        
    }

    // for Undefined Key
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
    
}
