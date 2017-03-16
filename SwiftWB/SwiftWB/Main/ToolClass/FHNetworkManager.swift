//
//  FHNetworkManager.swift
//  Alamofire Wrapping
//
//  Created by Figo Han on 2017-02-16.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import Alamofire
enum FH_methodType
{
    case GET, POST
    
}

class FHNetworkManager: SessionManager {

    static let sharedNetworkManager : FHNetworkManager = FHNetworkManager()
}

extension FHNetworkManager{
    
    
    /// send request to retrieve the statues for the home page
    ///
    ///   - Parameters:
    ///   - parameter: the parameters asked by api
    ///   - fh_completionHandler: call back closure
    func fh_requestStatuses(_ parameter : [String : Any], fh_completionHandler : @escaping (_ JSON: [Any]?, _ fh_error : Error?)-> ()) -> Void {
    
        self.request(FH_RequestStatusURLString, method: .get, parameters: parameter).responseJSON { (response) in
            
            if let JSON = response.result.value as? [String : Any]{
                
                guard let jsonStatues = JSON["statuses"] as? [Any] else{
                    
                    if let jsonError = response.result.error
                    {
                        fh_completionHandler(nil, jsonError)   // TODO: 这个地方需要改进，因为即使是请求错误那么也不会返回,要看文档怎么写的
                    }
                    return
                }
                
                fh_completionHandler(jsonStatues,nil)
            }
            
        }
    }
    
    
    
    
}
