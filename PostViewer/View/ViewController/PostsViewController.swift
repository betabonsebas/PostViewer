//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    private let interactor = AppInteractionController.shared
    private var data: ControllerData = ControllerData(list: [])
    @IBOutlet private var tableView: UITableView!
    private let cellIdentifier = String(describing: PostTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        interactor.getControllerData({ [weak self] (data: ControllerData) in
            self?.data = data
            self?.tableView.reloadData()
        })
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let model = data.list[indexPath.row]
        cell.setupWith(model)
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.goToPostDetail(from: self, with: data.list[indexPath.row] as! UIPost) { [weak self] (viewController) in
            self?.show(viewController, sender: nil)
        }
    }
}
