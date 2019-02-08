//
//  NetworkController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation
import Alamofire

class AlamofirePostDataController {
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
}

class AlamofireCommentDataController {
    private let baseURL = "https://jsonplaceholder.typicode.com/comments"
    
    func getRelated(to postId: Int, completion: @escaping (_ comments: [Comment]?) -> ()) {
        Alamofire.request("\(baseURL)?postId=\(postId)").responseData { response in
            switch response.result {
            case .success(let value):
                guard let comments = try? JSONDecoder().decode([Comment].self, from: value) else {
                    completion(nil)
                    return
                }
                completion(comments)
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
}

