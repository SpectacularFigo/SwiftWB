//
//  FHHomeTableViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHHomeTableViewController: FHBaseTableViewController {
    
    // MARK:- LazyLoading
    //这个地方就不能用private，因为extension获取不到
    fileprivate lazy var titlButton :FHTitleButton =      // 懒加载必须注明类型
        {
            var titleButton = FHTitleButton()
            titleButton.addTarget(self, action:#selector(titleButtonClick(titleButton:)), for: .touchUpInside)
            return titleButton
    }()
    
    
    
    // MARK:- Others
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin {
            return
        }
        
        setupNavigationItem()
    }
    
    deinit {
        print("deinit")
    }
    
}



// MARK:- UI Structure Setting
extension FHHomeTableViewController
{
    fileprivate func setupNavigationItem()
    {
        self.view.backgroundColor=UIColor.red
        navigationItem.titleView = titlButton
        // 重构代码， 用便利构造函数
        //        let leftBtn = UIButton()
        //        leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), for: .normal)
        //        leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"),  for: .highlighted)
        //        leftBtn.sizeToFit()
        //
        //        self.navigationItem.leftBarButtonItem=UIBarButtonItem.init(customView: leftBtn)
        //
        navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem=UIBarButtonItem(imageName: "navigationbar_pop")
        
    }
    
}


// MARK:- Events
extension FHHomeTableViewController
{
    
    @objc fileprivate func titleButtonClick(titleButton:FHTitleButton) -> Void {
        print("TitleBUtton click")
        titleButton.isSelected = !titleButton.isSelected // Default is NO
    }
    
    
}





