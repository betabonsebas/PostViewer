//
//  DetailViewModel.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

class DetailViewModel: ViewModel {
    
    private var client: Client
    private var model: PostViewModel
    var commentsDatasource: [CommentViewModel]
    
    var user: User?
    
    var title: String {
        return model.post.title
    }
    
    var postDescription: String {
        return model.post.body
    }
    
    var isFavorite: Bool {
        return model.isFavorite ?? false
    }
    
    func markFavorite() {
        model.isFavorite = !isFavorite
        let info = ["postId": model.post.id]
        if isFavorite {
            NotificationCenter.default.post(name: .favoritePost, object: nil, userInfo: info)
        }else{
            NotificationCenter.default.post(name: .unfavoritePost, object: nil, userInfo: info)
        }
    }
    
    init(model: PostViewModel, client: Client = NetworkClient()) {
        self.client = client
        self.model = model
        self.commentsDatasource = []
    }
    
    func fetchUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        client.fetch(api: UserAPI.getUser(id: model.post.userId)) { [weak self] (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                self?.user = user
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchComments(completion: @escaping (Result<Bool, Error>) -> Void) {
        client.fetch(api: CommentsAPI.getCommetsFor(post: model.post.id)) { [weak self] (result: Result<[Comment], Error>) in
            switch result {
            case .success(let comments):
                self?.fillCommentsDatasource(comments: comments)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        completion(.success(true))
    }
    
    private func fillCommentsDatasource(comments: [Comment]) {
        commentsDatasource.removeAll()
        comments.forEach { comment in
            commentsDatasource.append(CommentViewModel(comment: comment))
        }
    }
}
