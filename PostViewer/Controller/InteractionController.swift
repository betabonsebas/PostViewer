//
//  InteractionController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation

enum UIInteractionType {
    case refresh
    case favorite(id: Int)
    case delete(id: Int)
    case deleteAll
    case read(id: Int)
}

enum BackInteractionType {
    
}

protocol InteractionControllerProtocol {
    associatedtype T
    func listenUIInteraction(_ interaction: UIInteractionType)
    func receiveBackInteraction(completion: () -> [T])
}

class PostInteractionController: InteractionControllerProtocol {
    typealias T = Post
    
    func listenUIInteraction(_ interaction: UIInteractionType) {
        
    }
    
    func receiveBackInteraction(completion: () -> [Post]) {
        
    }
    
}
