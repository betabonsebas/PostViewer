//
//  MainViewModel.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

enum PostFilter {
    case all
    case favorites
}

class MainViewModel: ViewModel {
    
    private var client: Client
    private var all: [PostViewModel]
    var datasource: [PostViewModel]
    var updateCellAtIndex: ((_ index: Int) -> Void)?
    var title: String {
        return "Posts"
    }
    
    init(client: Client = NetworkClient()) {
        self.client = client
        self.datasource = []
        self.all = []
        NotificationCenter.default.addObserver(self, selector: #selector(favoritePost(_:)), name: .favoritePost, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unfavoritePost(_:)), name: .unfavoritePost, object: nil)
    }
    
    func deleteAllPost() {
        all.removeAll()
        datasource.removeAll()
    }
    
    func fetch(completion: @escaping (Result<Bool, Error>) -> Void) {
        client.fetch(api: PostsAPI.getPosts) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                self?.fillDatasource(posts: posts)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filter(with postFilter: PostFilter, completion: @escaping () -> Void) {
        datasource.removeAll()
        switch postFilter {
        case .favorites:
            datasource.append(contentsOf: all.filter({ $0.isFavorite ?? false }))
        default:
            datasource.append(contentsOf: all) 
        }
        completion()
    }
    
    func removePost(at index: Int) {
        all.remove(at: index)
        datasource.remove(at: index)
    }
    
    private func fillDatasource(posts: [Post]) {
        datasource.removeAll()
        all.removeAll()
        var unreadCount = 0
        posts.forEach { post in
            unreadCount += 1
            let viewModel = PostViewModel(post: post)
            viewModel.wasRead = unreadCount > 19
            datasource.append(viewModel)
        }
        
        all.append(contentsOf: datasource)
    }
    
    @objc private func favoritePost(_ notification: Notification) {
        if let postId = notification.userInfo?["postId"] as? Int {
            guard let index = datasource.firstIndex(where: { $0.post.id == postId}) else {
                return
            }
            
            datasource[index].isFavorite = true
            updateCellAtIndex?(index)
        }
    }
    
    @objc private func unfavoritePost(_ notification: Notification) {
        if let postId = notification.userInfo?["postId"] as? Int {
            guard let index = datasource.firstIndex(where: { $0.post.id == postId}) else {
                return
            }
            
            datasource[index].isFavorite = false
            updateCellAtIndex?(index)
        }
    }
}
