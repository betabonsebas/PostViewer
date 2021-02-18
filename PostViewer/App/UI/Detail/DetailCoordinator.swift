//
//  DetailCoordinator.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    var presenter: UINavigationController
    private var post: PostViewModel
    
    init(post: PostViewModel, presenter: UINavigationController = UINavigationController()) {
        self.presenter = presenter
        self.post = post
    }
    
    func navigate() {
        let detailViewController = DetailViewController.fromStoryboard()
        detailViewController.viewModel = DetailViewModel(model: post)
        detailViewController.coordinator = self
        self.presenter.pushViewController(detailViewController, animated: true)
    }
}
