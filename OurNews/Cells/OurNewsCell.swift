//
//  OurNewsCell.swift
//  AppForVK
//
//  Created by Mad Brains on 01.07.2020.
//  Copyright © 2020 Семериков Михаил. All rights reserved.
//

import UIKit

class OurNewsCell: UITableViewCell {

    @IBOutlet private weak var ownerImageView: UIImageView!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var newsTextLabel: UILabel!
    @IBOutlet private weak var newImageView: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var commentsButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var viewedImageView: UIImageView!
    @IBOutlet private weak var viewedLabel: UILabel!
    
    func configure(with news: News, owner: Owner?) {
        guard let uOwner = owner else {
            return
        }
        
        let userName = uOwner.userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let groupName = uOwner.groupName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        ownerNameLabel.text = userName.isEmpty ? groupName : userName
        
        ownerImageView.kf.setImage(with: URL(string: uOwner.ownerPhoto))
        
        newsTextLabel.text = news.postText
    }
    
}
