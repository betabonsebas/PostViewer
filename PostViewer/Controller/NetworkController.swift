//
//  NetworkController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    associatedtype T
    func getRelatedTo(id: Int, completion:@escaping(_ list: [T]) -> ())
    func getAll(_ completion:(_ list: [T]) -> ())
}

class PostNetworkController: NetworkProtocol {
    typealias T = Post
    
    func getRelatedTo(id: Int, completion: @escaping(_ list: [Post]) -> ()) {
        Alamofire.request("https://jsonplaceholder.typicode.com/posts/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"]).responseData(completionHandler: { (response) in
            switch (response.result) {
            case .success(let value):
                guard let data = try? JSONDecoder().decode([Post].self, from: value) else {
                    completion([])
                    return
                }
                completion(data)
            case .failure(let _):
                completion([])
            }
        })
        completion([])
    }
    
    func getAll(_ completion: (_ list: [Post]) -> ()) {
        completion([])
    }
}

class CommentNetworkController: NetworkProtocol {
    typealias T = Comment
    
    func getRelatedTo(id: Int, completion: (_ list: [Comment]) -> ()) {
        Alamofire.request("https://jsonplaceholder.typicode.com/comments/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"]).responseJSON(queue: nil, options: .allowFragments) { response in
            
        }
        completion([])
    }
    
    func getAll(_ completion: (_ list: [Comment]) -> ()) {
        completion([])
    }
}

class UserNetworkController: NetworkProtocol {
    typealias T = User
    
    func getRelatedTo(id: Int, completion: (_ list: [User]) -> ()) {
        Alamofire.request("https://jsonplaceholder.typicode.com/users/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"]).responseJSON(queue: nil, options: .allowFragments) { response in
            
        }
        completion([])
    }
    
    func getAll(_ completion: (_ list: [User]) -> ()) {
        completion([])
    }
}


