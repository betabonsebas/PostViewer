//
//  Post.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init() {
        self.userId = 0
        self.id = 0
        self.title = ""
        self.body = ""
    }
}

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    
    init() {
        self.postId = 0
        self.id = 0
        self.name = ""
        self.email = ""
        self.body = ""
    }
}

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    var website: String
    
    init() {
        self.id = 0
        self.name = ""
        self.email = ""
        self.phone = ""
        self.website = ""
    }
}
