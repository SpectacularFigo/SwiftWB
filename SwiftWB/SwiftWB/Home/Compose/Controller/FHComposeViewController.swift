//
//  FHComposeViewController.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-03-23.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import SnapKit
class FHComposeViewController: UIViewController {
    
    // MARK:- properties
    @IBOutlet weak var composeTextView: UITextView!
    
    var placeholderLabel : UILabel?
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var toolBarBotttomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var getPicButton: UIButton!
    
    
    
    // MARK:- system call backs
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.composeTextView.becomeFirstResponder()
    
        //        self.composeTextView.contentInset = UIEdgeInsets(top: 66, left:15, bottom: 0, right: 15)  // textView 继承自UIScrollView 等， contentInset 是UIScrollView 的属性。
        //        self.composeTextView.alwaysBounceHorizontal = false
        //        composeTextView.showsVerticalScrollIndicator = true
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        
        settingupNavigationITems()
        settingupPlaceHolderLabel()
        toolBarButtonSetup()
        
       
        
        
        // 设置监听
        // add observer to UITextView
        NotificationCenter.default.addObserver(self, selector: #selector(composedContentChanged(note:)), name: NSNotification.Name.UITextViewTextDidChange, object: composeTextView)
        
        
        // add observer to UIKeyborad
        NotificationCenter.default.addObserver(self, selector: #selector(toolBarChangesFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
       // After deinitializing observer must be removed from default notification center
       NotificationCenter.default.removeObserver(self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK:- UISetup
extension FHComposeViewController
{
    func settingupNavigationITems() -> Void {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissComposeController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postTweet))
        navigationItem.leftBarButtonItem?.isEnabled = false
        
    }
    
    
    func settingupPlaceHolderLabel() -> Void {
        
        
        let placeHolderLabel = UILabel()
        
        
        composeTextView.addSubview(placeHolderLabel)
        
        
        
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(composeTextView)
            make.leading.equalToSuperview()
        }
        
        
        placeHolderLabel.text = "What is Happening"
        placeHolderLabel.textColor = UIColor.orange
        placeHolderLabel.font = UIFont.systemFont(ofSize: 18.0)
        self.placeholderLabel = placeHolderLabel
        
    }
    
    func toolBarButtonSetup() {
        getPicButton.addTarget(self, action: #selector(getPicButtonClick), for: UIControlEvents.touchUpInside)
    }
}


// MARK:- Events
extension FHComposeViewController{
    
    
    @objc fileprivate func dismissComposeController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc fileprivate func postTweet(){
        
        print("postTweet")
    }
    
    
    
    @objc fileprivate func toolBarChangesFrame(notification: Notification){
        print(notification)
        let keyboardFrame = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        let keyboardHeight = keyboardFrame.height
        let animationDuration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        toolBarBotttomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    @objc fileprivate func composedContentChanged(note : NSNotification){

        if composeTextView.hasText {
            navigationItem.leftBarButtonItem?.isEnabled = true
            placeholderLabel?.isHidden = true
        }
        else{
            navigationItem.leftBarButtonItem?.isEnabled = false
             placeholderLabel?.isHidden = false
            
        }
        
    }
    
    @objc fileprivate func getPicButtonClick(){
        print("getPicButtonClick")
    }
}






