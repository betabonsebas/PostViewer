//
//  PostsAPI.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

enum PostsAPI: API {
    case getPosts
    case getPost(id: Int)
    
    var requestMethod: String {
        return "GET"
    }
    
    var requestPath: String? {
        return "/posts"
    }
    
    var requestPathParam: String? {
        switch self {
        case .getPost(let id):
            return "\(id)"
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
