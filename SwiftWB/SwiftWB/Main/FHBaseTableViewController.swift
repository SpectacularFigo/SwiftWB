//
//  FHBaseTableViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHBaseTableViewController: UITableViewController {
    
    // MARK:- LazyLoading
    var isLogin : Bool
        {
            
     var savePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
     savePath = (savePath as NSString).appendingPathComponent("account.plist")
        
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: savePath) as? FHUserAccount
        
        if account==nil {
            return false
        } else {
            return true
        }
    
    }
    fileprivate lazy var vistorView = FHVisitorView.visitorView()
    
    
    
    
    
    // MARK:- Others
    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

// MARK:- UI Structure Setting
extension FHBaseTableViewController
{

    func setupVisitorView()  {
        self.view=vistorView
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerNavigationItemClick))
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginNavigationBarItemCick))
    }
    
}


// MARK:- Events
extension FHBaseTableViewController
{
    
    @objc fileprivate func registerNavigationItemClick(){
        
        print("Register")
    }
    
    
    @objc fileprivate func loginNavigationBarItemCick(){
        let navigationController = UINavigationController()
        navigationController.addChildViewController(FHOAuthViewController())
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
}








