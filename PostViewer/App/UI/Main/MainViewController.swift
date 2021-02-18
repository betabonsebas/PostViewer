//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet private var tableView: UITableView!
    private let cellIdentifier = String(describing: DescriptionTableViewCell.self)
    var viewModel: MainViewModel! {
        didSet {
            viewModel.updateCellAtIndex = { [weak self] index in
                self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
    }
    var coordintator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        configureTableView()
        fetchPosts()
    }

    func fetchPosts() {
        viewModel.fetch { [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    @IBAction func refreshList(_ sender: UIBarButtonItem) {
        fetchPosts()
    }

    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        let filter: PostFilter
        switch sender.selectedSegmentIndex {
        case 1:
            filter = .favorites
        default:
            filter = .all
        }
        
        viewModel.filter(with: filter) { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func deleteAllAction(_ sender: Any) {
        viewModel.deleteAllPost()
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DescriptionTableViewCell else {
            return UITableViewCell()
        }
        let model = viewModel.datasource[indexPath.row]
        cell.setup(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removePost(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.datasource[indexPath.row]
        model.wasRead = true
        tableView.reloadRows(at: [indexPath], with: .none)
        coordintator.navigate(to: model)
    }
}
