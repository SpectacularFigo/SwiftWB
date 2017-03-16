//
//  FHUser.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-03-06.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHUser: NSObject {

    var profile_image_url : String?
    var verified : Bool?
    var online_status : Int?
    var name : String?
    
    init(dict : [String : AnyObject]){
        super.init()
        setValuesForKeys(dict)
        
    }
    
    //使用KVC但是不是所有的字段都赋值，需要重写这个方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
