//
//  FHOAuthViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-02-09.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import SVProgressHUD
class FHOAuthViewController: UIViewController , UIWebViewDelegate{
    
    @IBOutlet weak var oauthWebView: UIWebView!
    var tempURLStringArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let oauthUrl  = URL.init(string: OAuthRequestUrlString)
        let oauthURLRequest = URLRequest.init(url: oauthUrl!)
        oauthWebView.loadRequest(oauthURLRequest)
        // Do any additional setup after loading the view.
    }
    
    
}

// MARK:- UI Structure Setting
extension FHOAuthViewController
{
    fileprivate func setupUI()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(leftBarButtonItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Fill", style: .plain, target: self, action: #selector(rightBarButtonItemClick))
    }
    
}
// MARK:- Events - WebView Delegate Method
extension FHOAuthViewController
{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.setForegroundColor(UIColor.orange)
        SVProgressHUD.show(withStatus: "Loading")
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        
        let URLString = url.absoluteString
        
        guard URLString.contains("code=") else {
            return true
        }
        
        let separatedArray = URLString.components(separatedBy: "code=")
        
        let client_id = AppKey
        let client_secret = AppSecret
        let grant_type = "authorization_code"
        let code = separatedArray.last!
        let redirect_uri = "http://www.google.ca"
        
        let parameters = ["client_id" : client_id,
                          "client_secret":client_secret,
                          "grant_typecode":grant_type,
                          "code":code,
                          "redirect_uri":redirect_uri]
        
        
        
        
        GlobalSessionManager.fh_request(fh_methodType: .POST, URLString: Access_tokenURLString, parameters: parameters as [String : AnyObject]) { (result : [String : AnyObject]?, error :Error?) in
            
            if error != nil{
                
                print("THere is error\(error)")
                return
            }
            
            if result != nil{
                print("There are results\(result)")
                return
                
            }
        }
        

        
        return true
    }
}


// MARK:- Events
extension FHOAuthViewController
{
    
    @objc fileprivate func leftBarButtonItemClick()
    {
        dismiss(animated: true, completion: nil)
        
    }
    @objc fileprivate func rightBarButtonItemClick()
    {
        let jsCode = "document.getElementById('userId').value='0015199918365';document.getElementById('passwd').value='figo2014';"
        
        // 2.执行js代码
        oauthWebView.stringByEvaluatingJavaScript(from: jsCode)
        
    }
    
    
    
}
