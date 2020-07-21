//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 15.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties

    let tableView = UITableView()
    
    init() {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        // register cell with tableView
        //tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
}

// MARK: - Extension (Data Source)

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // delete favorite
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

    }
}

// MARK: - Extension (Delegate)

extension FavoritesViewController: UITableViewDelegate{
    
    // didselectrow - show followers from selected favorite
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
