//
//  FHNetworkManager.swift
//  Alamofire Wrapping
//
//  Created by Figo Han on 2017-02-16.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import Alamofire
enum FH_methodType {
    case GET, POST
}

class FHNetworkManager: SessionManager {
    static let sharedInstance: FHNetworkManager = FHNetworkManager()
    
    func requestStatusCollection(_ parameter : [String : Any], completionHandler : @escaping (_ statusesArray: [FHStatues]?, _ error : Error?)-> ()) -> Void {
        self.request(FH_RequestStatusURLString, method: .get, parameters: parameter).responseData { (response) in
            switch response.result {
            case .success:
                if let responseData = response.result.value, let statusCollection = try? JSONDecoder().decode(StatusCollection.self, from: responseData), let statusesArray = statusCollection.statuses {
                    completionHandler(statusesArray,nil)
                }
            case .failure:
                completionHandler(nil,response.result.error!)
            }
        }
    }
}
