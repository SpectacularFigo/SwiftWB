//
//  FHHomeTableViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-07.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import Alamofire
import UIKit

class FHHomeTableViewController: FHBaseTableViewController {
    
    // MARK: - LazyLoading
    fileprivate lazy var statusViewModelArray = [FHStatusViewModel]()
    fileprivate lazy var titlButton: FHTitleButton = { // 懒加载必须注明类型
        var titleButton = FHTitleButton()
        titleButton.addTarget(self, action: #selector(titleButtonClick(titleButton:)), for: .touchUpInside)
        return titleButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin {
            return
        }
        setupFooterView()
        setupNavigationItem()
        setupRefreshControl()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
    }
}

// MARK: - UI Setups
extension FHHomeTableViewController {
    fileprivate func setupFooterView() {
        let footerView = FHHomeCellFooterView.footerView()
        self.tableView.tableFooterView = footerView
        self.tableView.tableFooterView?.isHidden = true
        
    }
    
    fileprivate func setupNavigationItem() {
        navigationItem.titleView = titlButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
    }
    
    fileprivate func setupRefreshControl() {
        self.refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        self.refreshControl?.addTarget(self, action: #selector(requestNeworMoreStatus), for: .valueChanged)
        requestStatuses()
    }
}

// MARK:- UI Actions
extension FHHomeTableViewController {
    @objc fileprivate func titleButtonClick(titleButton: FHTitleButton) {
        print("TitleBUtton click")
        titleButton.isSelected = !titleButton.isSelected // Default is NO
    }
    
    @objc fileprivate func requestNeworMoreStatus() {
        print("requestNeworMoreStatus")
        self.requestStatuses()
    }
}

// MARK:- Network Request
extension FHHomeTableViewController {
     fileprivate func loadMoreTweets() {
        let access_token = FHAccountTool.accessToken()
        guard let accessTokenTemp = access_token else { return }
        var max_id = "0"
        if !self.statusViewModelArray.isEmpty {
            max_id = (self.statusViewModelArray.last?.status?.idstr)!
        }
        let parameter = ["access_token": accessTokenTemp, "since_id": max_id] as [String: Any]
        
        FHNetworkManager.sharedInstance.requestStatusCollection(parameter) { [weak self] statusArray,error in
            if let statusArray = statusArray {
                for status in statusArray {
                    let statusViewModel = FHStatusViewModel(status: status)
                    self?.statusViewModelArray.append(statusViewModel)
                }
                self?.tableView.reloadData()
                self?.tableView.tableFooterView?.isHidden = true
            }
            if let error = error {
                print(error) // FIXME: Error Handling
            }
        }
    }


    fileprivate func requestStatuses() {
        let access_token = FHAccountTool.accessToken()
        guard let accessTokenTemp = access_token else {
            print("There is not an access_token")
            return
        }
        var since_id = "0"
        if !self.statusViewModelArray.isEmpty {
            since_id = (self.statusViewModelArray[0].status?.idstr)!
        }
        let parameter = ["access_token": accessTokenTemp, "since_id": since_id] as [String: Any]
        
        FHNetworkManager.sharedInstance.requestStatusCollection(parameter) { (statusArray,error) in
            if let statusArray = statusArray {
                var tempStatusViewModelArray = [FHStatusViewModel]()
                for status in statusArray {
                    let statusViewModel = FHStatusViewModel(status: status)
                    tempStatusViewModelArray.append(statusViewModel)
                }
                self.statusViewModelArray = tempStatusViewModelArray + self.statusViewModelArray
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            if let error = error {
                print(error) // FIXME: Error Handling
            }
        }
    }
}

// MARK: - TableView Delegate and Datasource Methods
extension FHHomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusViewModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier") as! FHHomeCell
        cell.statusViewModel = self.statusViewModelArray[indexPath.row]
        return cell
        
    }
}

// MARK:- ScrollView Delegate Methods
extension FHHomeTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.statusViewModelArray.count == 0 { return }
        let offsetY = scrollView.contentOffset.y
        let judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - (self.tableView.tableFooterView?.height)!
        if offsetY >= judgeOffsetY { // 最后一个cell完全进入视野范围内
            self.tableView.tableFooterView?.isHidden = false // 显示footer
            self.loadMoreTweets() // 加载更多的微博数据
        }
    }
}

