//
//  FHVisitorView.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHVisitorView: UIView {

    
    fileprivate lazy var array = [Int]()
    class func visitorView() -> FHVisitorView {
        return Bundle.main.loadNibNamed("visitorView", owner: nil, options: nil)!.first as! FHVisitorView
    }
  
    @IBAction func registerButtonClick(_ sender: UIButton) {
        print("Register")
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
         print("login")
    }

    
    
}
