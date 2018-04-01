//
//  FHStatusViewModel.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-03-06.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

struct FHStatusViewModel {
    var status : FHStatues?
    var createDateTime : String?
    var createSource : String?
    var pic_URLs : [[String : String]]?
    var pic_Count : Int?
    var entireRetweet : String?
    
    init(status: FHStatues) {
        self.status = status // FIXME: Remove status property if have time
        if let createDateTime = self.status?.created_at {
           self.createDateTime = FHDateTool.fh_date(dateTimeString: createDateTime)
        }
      
        // MARK:- Source
        if let source = status.source, source != "" {
                let startedIndex = (source as NSString).range(of: ">").location + 1
                let length = (source as NSString).range(of: "</").location - startedIndex
                self.createSource = "from " + (source as NSString).substring(with: NSMakeRange(startedIndex, length))
        }
        
        // MARK:- Picture URL
        if let pic_URLs = status.pic_urls?.count == 0 ? status.retweeted_status?.pic_urls : status.pic_urls{
            self.pic_URLs = pic_URLs
            self.pic_Count = pic_URLs.count
        } else {
            self.pic_URLs = []
            self.pic_Count = 0
        }
        
        // MARK:- Retweeted Status
        if let retweetedUserName = status.retweeted_status?.user?.name , let retweetedText = status.retweeted_status?.text{
            self.entireRetweet = "@"+retweetedUserName+": " + retweetedText
        }
    }
}
