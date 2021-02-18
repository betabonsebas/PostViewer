//
//  PostViewModel.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

class PostViewModel {
    var post: Post
    var wasRead: Bool?
    var isFavorite: Bool?
    
    var description: String {
        return post.body
    }
    
    init(post: Post) {
        self.post = post
    }
}
