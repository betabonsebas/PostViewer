//
//  PostTableViewCell.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var stateIndicatorImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var indicatorImage: UIImageView!
    
    func setupWith<T>(_ data: T) {
        if let model = data as? UIPost, let read = model.read, let favorite = model.favorite {
            descriptionLabel.text = model.description
            stateIndicatorImage.image = nil
            if !read {
                stateIndicatorImage.image = UIImage(named: "unread")
            }
            if favorite {
                stateIndicatorImage.image = UIImage(named: "favoritePost")
            }
        }

        if let model = data as? Comment {
            descriptionLabel.text = model.body
            stateIndicatorImage.isHidden = true
            indicatorImage.isHidden = true
        }
    }
    
}
