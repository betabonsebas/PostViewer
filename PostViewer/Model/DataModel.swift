//
//  DataModel.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 7/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation

protocol UIData {
    var list: [Codable] { get }
    var Model: Codable? { get set }
    init(list: [Codable])
}

struct ControllerData: UIData {
    var Model: Codable?
    var list: [Codable]
    init(list: [Codable]) {
        self.list = list
        self.Model = nil
    }
}

struct UIPost: Codable {
    var post: Post
    var read: Bool?
    var favorite: Bool?
    
    var description: String {
        return post.body
    }
    
    init(_ post: Post) {
        self.post = post
        self.read = false
        self.favorite = false
    }
}
