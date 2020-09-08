//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import Utils

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: FavoritesViewModel
    
    var flowDelegate: AppFlowControllerDelegate?
    
    let tableView = UITableView()
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        configureCostraints()
        bind()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flowDelegate?.shouldHideToolbar(hide: false)
 //       self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        //tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        // register cell with tableView
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }

    private func bind() {
        viewModel.outputs.showFollowersForUsername = { [weak self] (username) in
            guard let self = self else { return }
            self.flowDelegate?.showFollowers(forUser: username)
        }
    }
}

// MARK: - UI Costraints

extension FavoritesViewController {
    private func configureCostraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            //tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extension (Data Source)

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: create a viewModel method to hide details
        viewModel.favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as! FavoritesCell
        cell.set(favorite: viewModel.favorites[indexPath.row])
        return cell
    }

    // delete favorite
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        viewModel.deleteFollowerAt(indexPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                tableView.deleteRows(at: [indexPath], with: .left)
                break
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
}

// MARK: - Extension (Delegate)

extension FavoritesViewController: UITableViewDelegate{
    
    // didselectrow - show followers from selected favorite
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
    }
}


