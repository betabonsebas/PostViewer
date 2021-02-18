//
//  PostTableViewCell.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet var stateIndicatorImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var indicatorImage: UIImageView!
    
    func setup(_ model: PostViewModel) {
        descriptionLabel.text = model.description
        stateIndicatorImage.image = nil
        if !(model.wasRead ?? true) {
            stateIndicatorImage.image = UIImage(named: "unread")
        }
        
        if model.isFavorite ?? false {
            stateIndicatorImage.image = UIImage(named: "favoritePost")
        }
    }
    
    func setup(_ model: CommentViewModel) {
        descriptionLabel.text = model.comment.body
        stateIndicatorImage.isHidden = true
        indicatorImage.isHidden = true
    }
    
}
