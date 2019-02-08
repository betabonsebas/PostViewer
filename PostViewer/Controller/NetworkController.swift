//
//  NetworkController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation
import Alamofire

class AlamofirePostDataController: DataProtocol {
    typealias T = Post
    
    private let baseURL = "https://jsonplaceholder.typicode.com/posts/"
    
    func get(id: Int, completion: @escaping (Post?) -> ()) {
        Alamofire.request("\(baseURL)\(id)").responseData { response in
            switch response.result {
            case .success(let value):
                guard let post = try? JSONDecoder().decode(Post.self, from: value) else {
                    completion(nil)
                    return
                }
                completion(post)
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
    
    func getAll(completion: @escaping ([Post]?) -> ()) {
        Alamofire.request(baseURL).responseData { response in
            switch response.result {
            case .success(let value):
                guard let post = try? JSONDecoder().decode([Post].self, from: value) else {
                    completion(nil)
                    return
                }
                completion(post)
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
    
    func save(_ models: [Post], completion: @escaping (Bool) -> ()) {
        
    }
    
    func delete(id: Int, completion: @escaping (Bool) -> ()) {
        
    }
    
    func deleteAll() {
        
    }
}

class AlamofireCommentDataController: DataProtocol {
    typealias T = Comment
    
    private let baseURL = "https://jsonplaceholder.typicode.com/comments/"
    
    func get(id: Int, completion: @escaping (Comment?) -> ()) {
        Alamofire.request("\(baseURL)\(id)").responseData { response in
            switch response.result {
            case .success(let value):
                guard let post = try? JSONDecoder().decode(Comment.self, from: value) else {
                    completion(nil)
                    return
                }
                completion(post)
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
    
    func getAll(completion: @escaping ([Comment]?) -> ()) {
        Alamofire.request(baseURL).responseData { response in
            switch response.result {
            case .success(let value):
                guard let post = try? JSONDecoder().decode([Comment].self, from: value) else {
                    completion(nil)
                    return
                }
                completion(post)
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
    
    func save(_ models: [Comment], completion: @escaping (Bool) -> ()) {
        
    }
    
    func delete(id: Int, completion: @escaping (Bool) -> ()) {
        
    }
    
    func deleteAll() {
        
    }
}

