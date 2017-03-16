        //
//  FHHomeTableViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import Alamofire

class FHHomeTableViewController: FHBaseTableViewController {
    
    // MARK:- LazyLoading
    fileprivate lazy var statusViewModelArray = [FHStatusViewModel]()
    
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
        
        setupRefreshControl()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
     
        
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
    
    fileprivate func setupRefreshControl() -> Void
    {
        self.refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        self.refreshControl?.addTarget(self, action: #selector(requestNeworMoreStatus), for: .valueChanged)
        self.refreshControl?.beginRefreshing()
        
        // NOTICE : beginingRefreshing will not make UIControl state become valueChange so that func requestNeworMoreStatus will never be called. This is why I should call requestStatues() function, because it may cause some values changing, as a result event valueChanged is created.
       
        
        requestStatuses()
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.statusViewModelArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier") as! FHHomeCell
        
        cell.statusViewModel = self.statusViewModelArray[indexPath.row]
        
        return cell
        
    }
    
}

        
        
// MARK:- Events
extension FHHomeTableViewController
{
    
    @objc fileprivate func titleButtonClick(titleButton:FHTitleButton) -> Void {
        print("TitleBUtton click")
        titleButton.isSelected = !titleButton.isSelected // Default is NO
    }
    
    @objc fileprivate func requestNeworMoreStatus() -> Void
    {
        print("requestNeworMoreStatus")
         requestStatuses()
    }
    
    func requestStatuses() -> Void {
        
        let searchPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("account.plist")
        
        let userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: searchPath) as? FHUserAccount
        
        
        guard let userAccountTemp = userAccount else {
            print("There is no userAccount")
            return
        }
        
        guard let accessTokenTemp = userAccountTemp.access_token else {
            print("There is not an access_token")
            return
        }
        
        
        var since_id = "0"
        
        if !self.statusViewModelArray.isEmpty {
            since_id = (self.statusViewModelArray[0].status?.idstr)!
        }

        
        let parameter = ["access_token" : accessTokenTemp , "since_id": since_id] as [String : Any]
        
        FHNetworkManager.sharedNetworkManager.fh_requestStatuses(parameter) { (fh_JSONStatuses, fh_error) in
        
        guard let JSONStatues = fh_JSONStatuses else{
            
            print("There is an error in the request")
            return
        }
        
        var tempStatusViewModelArray = [FHStatusViewModel]()
            
        for i in 0..<JSONStatues.count
        {
            
            let statusTemp = JSONStatues[i] as! [String : AnyObject]
            let status = FHStatues.init(dict: statusTemp)
            let statusViewModel = FHStatusViewModel.init(status: status)
            tempStatusViewModelArray.append(statusViewModel)
        }
        
        self.statusViewModelArray = tempStatusViewModelArray + self.statusViewModelArray
            
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        }
    
    
    
}

}

