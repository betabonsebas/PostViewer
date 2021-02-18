//
//  DetailViewController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, StoryboardInstantiable {
    
    private let cellIdentifier = String(describing: DescriptionTableViewCell.self)
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var userInfoContainer: UIStackView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userWebsiteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var viewModel: DetailViewModel!
    var coordinator: DetailCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupOutlets()
        fetchUser()
        fetchComments()
    }
    
    private func setupOutlets() {
        postDescriptionLabel.text = viewModel.postDescription
        userInfoContainer.isHidden = true
        tableView.isHidden = true
        favoriteButton.image = viewModel.isFavorite ? UIImage(named: "favoritePost") : UIImage(named: "favorite")
    }
    
    private func setupUserData() {
        guard let user = viewModel.user else {
            return
        }
        userInfoContainer.isHidden = false
        userNameLabel.text = "Name: \(user.name)"
        userEmailLabel.text = "Email: \(user.email)"
        userPhoneLabel.text = "Phone: \(user.phone)"
        userWebsiteLabel.text = "Website: \(user.website)"
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func fetchUser() {
        viewModel.fetchUser { [weak self] result in
            switch result {
            case .success:
                self?.setupUserData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchComments() {
        viewModel.fetchComments { [weak self] result in
            switch result {
            case .success:
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func favoritePost(_ sender: UIBarButtonItem) {
        viewModel.markFavorite()
        favoriteButton.image = viewModel.isFavorite ? UIImage(named: "favoritePost") : UIImage(named: "favorite")
    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commentsDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DescriptionTableViewCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.commentsDatasource[indexPath.row]
        cell.setup(model)
        
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "COMMENTS"
    }
}
