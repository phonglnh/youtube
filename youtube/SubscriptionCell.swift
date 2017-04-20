//
//  SubscriptionCell.swift
//  youtube
//
//  Created by PhongLe on 4/4/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
