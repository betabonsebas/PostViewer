//
//  CommentsAPI.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

enum CommentsAPI: API {
    case getCommetsFor(post: Int)
    
    var requestMethod: String {
        return "GET"
    }
    
    var requestPath: String? {
        return "/comments"
    }
    
    var requestPathParam: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCommetsFor(let postId):
            return [URLQueryItem(name: "postId", value: "\(postId)")]
        }
    }
}
