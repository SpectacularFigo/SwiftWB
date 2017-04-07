        //
//  FHHomeTableViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh

class FHHomeTableViewController: FHBaseTableViewController {
    
    // MARK:- LazyLoading
    fileprivate lazy var statusViewModelArray = [FHStatusViewModel]()
    fileprivate lazy var titlButton :FHTitleButton =      // 懒加载必须注明类型   //这个地方就不能用private，因为extension获取不到  This is a computing property
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        setupFooterView()
        setupNavigationItem()
        setupRefreshControl()
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
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTweet))
    
    
        
    }
    
    fileprivate func setupRefreshControl() -> Void
    {
        self.refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        self.refreshControl?.addTarget(self, action: #selector(requestMoreNewTweets), for: .valueChanged)
        self.refreshControl?.beginRefreshing()
        
        // NOTICE : beginingRefreshing will not make UIControl state become valueChange so that func requestMoreNewTweets will never be called. This is why I should call requestStatues() function, because it may cause some values changing, as a result event valueChanged is created.
        requestStatuses(fetchNewData: true)
    
    }
    
    
    fileprivate func setupFooterView()
    {
        let footerView = FHHomeCellFooterView.footerView()
        self.tableView.tableFooterView = footerView
        self.tableView.tableFooterView?.isHidden = true
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(requestMoreOldTweets))
    }


    
}

        
        
// MARK:- Events
extension FHHomeTableViewController
{
    
    @objc fileprivate func titleButtonClick(titleButton:FHTitleButton) -> Void {
        print("TitleBUtton click")
        titleButton.isSelected = !titleButton.isSelected // Default is NO
    }
    
    
    
    @objc fileprivate func requestMoreNewTweets() -> Void
    {
        print("requestMoreNewTweets")
        requestStatuses(fetchNewData: true)
    }
    
    
    @objc fileprivate func requestMoreOldTweets() ->Void{
        
        print("requestMoreOldTweets")
        requestStatuses(fetchNewData: false)
        
    }
    
    
    
    @objc fileprivate func composeTweet() ->Void
    {
        
        let composeNavigationCon = UINavigationController(rootViewController: FHComposeViewController())
//        composeNavigationCon.modalPresentationStyle = .pageSheet
//        composeNavigationCon.modalTransitionStyle = .partialCurl
        self.present(composeNavigationCon, animated: true) {}
        
    }
    
    
    
     func requestStatuses(fetchNewData: Bool) -> Void {
        
        let access_token = FHAccountTool.accessToken()
        
        guard let accessTokenTemp = access_token else {
             print("There is not an access_token")
             return
        }
        
        // check if fetech new Tweets
        var parameter = [String : Any]()
        var since_id = "0"
        var max_id = "0"
        
        
        if !self.statusViewModelArray.isEmpty {
            since_id = (self.statusViewModelArray[0].status?.idstr)!
            max_id = (self.statusViewModelArray.last?.status?.idstr)!
        }
        if fetchNewData {
            
            parameter = ["access_token" : accessTokenTemp , "since_id": since_id]
        }else{
            
            parameter = ["access_token" : accessTokenTemp , "max_id": max_id]
            
        }
        
       
        
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
        self.tableView.mj_footer.endRefreshing()
        }
}

}

        
// MARK:- NOTE: cellforHeight 我没用那个， 回头看看
// MARK:- Delegate and Datasource Methods
extension FHHomeTableViewController
        {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.statusViewModelArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier") as! FHHomeCell
        
        cell.statusViewModel = self.statusViewModelArray[indexPath.row]
        
        return cell
        
    }
        }
        
        
