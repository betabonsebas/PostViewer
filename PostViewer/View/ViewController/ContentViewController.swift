//
//  ContentViewController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    private let interactor = AppInteractionController.shared
    private let cellIdentifier = String(describing: PostTableViewCell.self)
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userWebsiteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!

    var post: UIPost? {
        didSet {
            guard var post = post else {
                return
            }
            self.loadViewIfNeeded()
            post.read = true
            interactor.updatePost(post) { _ in }
            postDescriptionLabel.text = post.post.body
            favoriteButton.image = post.favorite ?? false ? UIImage(named: "favorite") : UIImage(named: "favoriteSelected")
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    @IBAction func favoritePost(_ sender: UIBarButtonItem) {
        guard var post = self.post else {
            return
        }

        post.favorite = true
        interactor.updatePost(post) { [weak self] (success) in
            self?.favoriteButton.image = success ? UIImage(named: "favoriteSelected") : UIImage(named: "favorite")
        }
    }

}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = post?.comments?.count else {
            return 0
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        guard let model = post?.comments?[indexPath.row] else {
            return cell
        }
        cell.setupWith(model)
        return cell
    }

}

extension ContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
}
