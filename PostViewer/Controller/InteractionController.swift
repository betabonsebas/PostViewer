//
//  InteractionController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation
import UIKit

class AppInteractionController {
    
    public static var shared: AppInteractionController = AppInteractionController()
    private var postNetworkController: AlamofirePostDataController = AlamofirePostDataController()
    private var commentNetworkController: AlamofireCommentDataController = AlamofireCommentDataController()
    private var persistenceController: PListDataController = PListDataController()
    
    func getControllerData<T: UIData>(_ completion: @escaping(_ data: T) -> Void) {
        switch T.self {
        case is ControllerData.Type:
            persistenceController.getAll { [weak self] posts in
                guard let uiPosts = posts else {
                    self?.getNetworkData(completion)
                    return
                }
                completion(T(list: uiPosts))
            }
        default:
            break
        }
    }

    func getRefreshedControllerData<T: UIData>(_ completion: @escaping(_ data: T) -> Void) {
        getNetworkData(completion)
    }

    private func getNetworkData<T: UIData>(_ completion: @escaping(_ data: T) -> Void) {
        postNetworkController.getAll { (posts) in
            guard let posts = posts else {
                completion(T(list: []))
                return
            }

            let uiPosts = posts.compactMap({ (post) -> UIPost? in
                var uiPost = UIPost(post)
                uiPost.read = post.id > 20
                return uiPost
            })
            self.savePosts(uiPosts)
            completion(T(list: uiPosts))
        }
    }

    private func savePosts(_ posts: [UIPost]) {
        persistenceController.save(posts) { (success) in
            print("data saved successfully? ->\(success)")
        }
    }
    
    func contentData(with post: UIPost, completion: @escaping(_ dataToShow: UIPost) -> Void) {
        guard post.comments != nil else {
            commentNetworkController.getRelated(to: post.post.id) { comments in
                var postToShow = post
                postToShow.comments = comments
                self.updatePost(postToShow, completion: { success in
                    print("model updata successfully: \(success)")
                })
                completion(postToShow)
            }
            return
        }
        completion(post)
    }

    func updatePost(_ post: UIPost, completion: @escaping (Bool) -> ()) {
        persistenceController.update(post, completion: completion)
    }
    
}

