//
//  MainCoordinator.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var presenter: UINavigationController
    
    init(presenter: UINavigationController = UINavigationController()) {
        self.presenter = presenter
    }
    
    func navigate() {
        let mainViewController = MainViewController.fromStoryboard()
        mainViewController.viewModel = MainViewModel()
        mainViewController.coordintator = self
        self.presenter.pushViewController(mainViewController, animated: true)
    }
    
    func navigate(to post: PostViewModel) {
        let detailCoordinator = DetailCoordinator(post: post, presenter: presenter)
        detailCoordinator.navigate()
    }
}
