//
//  Protocols.swift
//  SwiftWB
//
//  Created by Figo Han on 2018-04-01.
//  Copyright © 2018 Figo Han. All rights reserved.
//

import UIKit

protocol canTriggerApologyAlert {
    func popupApologyAlert()
}

extension canTriggerApologyAlert where Self: UIViewController {
    func popupApologyAlert() {
        let alertController = UIAlertController(title: , message: <#T##String?#>, preferredStyle: <#T##UIAlertControllerStyle#>)
    }
}
