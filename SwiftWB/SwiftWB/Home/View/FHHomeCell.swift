//
//  FHHomeCell.swift
//  SwiftWB
//
//  Created by Figo Han on 2017-03-06.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import SDWebImage
class FHHomeCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    
    @IBOutlet weak var createSourceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var collectionViewHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewWConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var reweetedLabel: UILabel!
    
    var itemH : CGFloat?
    
    var statusViewModel : FHStatusViewModel?
    {
        didSet
        {
            if let statusViewModel = statusViewModel {
                
             if let profileImageString = statusViewModel.status?.user?.profile_image_url
               {
                  let profileImageURL = URL(string: profileImageString)!
                  self.profileImageView.sd_setImage(with: profileImageURL, placeholderImage: UIImage(named: "avatar_default"))
                }

                self.profileNameLabel.text = statusViewModel.status?.user?.name
                self.createTimeLabel.text = statusViewModel.createDateTime
                self.createSourceLabel.text = statusViewModel.createSource
                self.statusLabel.text = statusViewModel.status?.text
                self.reweetedLabel.text = statusViewModel.entireRetweet
                
                
                //collectionView number of rows condition
                
                if let pic_count = statusViewModel.pic_Count {
                    
                    if pic_count != 0{
                        
                        if pic_count < 4 {
                            collectionViewHConstraint.constant = itemH!
                        }
                            
                        else if pic_count < 7{
                            collectionViewHConstraint.constant = itemH!*2 + 10.0
                        }
                        else
                        {
                            collectionViewHConstraint.constant = itemH!*3 + 20.0
                        }
                    }
                    else
                    {
                        self.collectionViewHConstraint.constant = 0.0
                        self.collectionViewWConstraint.constant = 0.0
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
      itemH = (screenWidth - 2*screenMargin - 2*itemMargin)/3
     
      collectionFlowLayout.itemSize = CGSize(width: itemH!, height: itemH!)
        
    }



}

// MARK:- Events
extension FHHomeCell
{
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.statusViewModel?.pic_URLs?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifierCollectionCell", for: indexPath) as! FHHomeCollectionCell
        let picURlDict = (self.statusViewModel?.pic_URLs?[indexPath.row])!
        let picURLString = picURlDict["thumbnail_pic"]
        let picURL = URL(string: picURLString!)
        cell.collectionCellImageView.sd_setImage(with: picURL!, placeholderImage: UIImage(named: "empty_picture"))
        return cell
        
    }
    
    
}
