//
//  FHTitleButton.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHTitleButton: UIButton {
    
    override init(frame:CGRect)
    {
        super.init(frame: frame)  // Must override a designated initializer??????
        setImage(UIImage.init(named: "navigationbar_arrow_up"), for: .normal)
        setImage(UIImage.init(named: "navigationbar_arrow_down"), for: .selected)
        setTitle("iOS Developer", for: .normal)
        setTitle("iOS Developer", for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.orange, for: .selected)
        sizeToFit()
                
    }
    
    //This method is required to override if you override init() method. This method aims at load XIB.
    // 系统加载类的顺序就是先加载SB(同名的),XIB（同名的）,Code 所有控件重写init方法的时候都要重写这个方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


















