//
//  UserAPI.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

enum UserAPI: API {
    case getUser(id: Int)
    
    var requestMethod: String {
        return "GET"
    }
    
    var requestPath: String? {
        return "/users"
    }
    
    var requestPathParam: String? {
        switch self {
        case .getUser(let id):
            return "/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
