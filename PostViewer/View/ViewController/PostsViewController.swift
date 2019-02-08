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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    func configureAndShowContentViewController(with post: UIPost) {
        let viewControllerName = String(describing: ContentViewController.self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? ContentViewController else {
            return
        }
        viewController.post = post
        self.show(viewController, sender: nil)
    }

    @IBAction func refreshList(_ sender: UIBarButtonItem) {
        interactor.getRefreshedControllerData({ [weak self] (data: ControllerData) in
            self?.data = data
            self?.tableView.reloadData()
        })
    }

    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            break
        default:
            interactor.getControllerData({ [weak self] (data: ControllerData) in
                self?.data = data
                self?.tableView.reloadData()
            })
        }
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
        interactor.contentData(with: data.list[indexPath.row] as! UIPost) { [weak self] post in
            self?.configureAndShowContentViewController(with: post)
        }
    }
}
