//
//  FHStatues.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-16.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

struct StatusCollection: Codable {
    var statuses: [FHStatues]?
}

struct FHStatues: Codable {
    var created_at: String?
    var idstr: String?
    var text: String?
    var source: String?
    var user: FHUser?
    var pic_urls: [[String : String]]?
    var retweeted_status: FHRetweetstatues?
}

struct FHRetweetstatues: Codable {
    var created_at: String?
    var idstr: String?
    var text: String?
    var source: String?
    var user: FHUser?
    var pic_urls: [[String : String]]?
}

struct FHUser: Codable{
    var profile_image_url : String?
    var verified : Bool?
    var online_status : Int?
    var name : String?
}

