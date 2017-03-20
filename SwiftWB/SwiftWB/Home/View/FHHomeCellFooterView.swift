//
//  FHHomeCellFooterView.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-03-15.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHHomeCellFooterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func footerView() -> (FHHomeCellFooterView)
    {
        
        return Bundle.main.loadNibNamed("FHHomeCellFooterView", owner: nil, options: nil)?.last as! (FHHomeCellFooterView)
        
    }
   

}
