//
//  FHSessionManager.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-09.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import AFNetworking

enum methodType : String
{
    case GET = "GET"
    case POST = "POST"
}
class FHSessionManager: AFHTTPSessionManager {
    
    static let sharedSessionManager : FHSessionManager =
        {
           let sharedSessionManager = FHSessionManager()
            sharedSessionManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
            sharedSessionManager.responseSerializer = AFJSONResponseSerializer()
            
           return sharedSessionManager
    }()

}

extension FHSessionManager
{
    
  
    /// Sending request to the server, now only supports GET and POST Request
    ///
    /// - Parameters:
    ///   - fh_methodType: enumeration
    ///   - URLString: url
    ///   - parameters: request parameters as Dictionary
    ///   - completion: closure to call back
    
    func fh_request(fh_methodType: methodType, URLString: String, parameters:[String: AnyObject], completion:  @escaping (_ result: [String : AnyObject]?, _ error : Error?)->())  {
        
        if fh_methodType == .GET {
            
            self.get(URLString, parameters: parameters, progress: nil, success: { (task: URLSessionTask, reslut: Any?) in
                completion(reslut as? [String: AnyObject] , nil)
            }) { (task: URLSessionTask?, error: Error) in
                completion(nil, error)
            }
        }
        else
        {
            
            self.post(URLString, parameters: parameters, progress: nil, success: { (task: URLSessionTask, result: Any?) in
                completion(result as? [String : AnyObject], nil)
            }, failure: { (task:URLSessionTask?, error: Error) in
                completion(nil, error)
            })
            
        }
        
    }
    
    
}
