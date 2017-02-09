//
//  UIBarButtonItem-Extension.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    /// 用来代替类方法的 在用便利构造方法的时候必须实现调用一遍init方法.不然会报错
    
    /**
     用来代替类方法的 在用便利构造方法的时候必须实现调用一遍init方法.不然会报错
     */
    convenience init(imageName: String) {
        
        self.init()  // 必须调用
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.setImage(UIImage.init(named: imageName+"_highlighted"), for: .highlighted)
        //TODO: 不写sizeToFit 显示不出来
        button.sizeToFit()
        self.customView=button
        
       
//        let button = UIButton()
//        button.setImage(UIImage.init(named: imageName), for: .normal)
//        button.setImage(UIImage.init(named: imageName+"_highlighted"), for: .highlighted)
//        self.init(customView: button)
       
        
    }
//    init(viewName: String)
//    {
//        super.init(frame:CGRect)
//        
//    }
}
