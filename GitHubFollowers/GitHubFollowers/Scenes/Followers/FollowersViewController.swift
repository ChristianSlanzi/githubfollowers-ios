//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 22.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    var viewModel: FollowersViewModel
    
    var flowDelegate: AppFlowControllerDelegate?
    
    var collectionView: UICollectionView!
    
    // MARK: - Viewcontroller Lifecycle
    
    init(viewModel: FollowersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: CollectionViewHelper.createThreeColumnFlowLayout(in: view)
        )
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    @objc func addButtonTapped() {
    }
    
    private func bind() {
        viewModel.outputs.reloadData = { [weak self] (followers) in
            guard let self = self else { return }
            if followers.isEmpty {
                let title = "Bad Luck"
                let message = "This user does not have any followers. Go follow them. 😃"
                self.presentAlertOnMainThread(title: title, message: message, buttonTitle: "OK")
                return
            }
            DispatchQueue.main.async {
                self.reloadData(followers)
            }
        }
        
        viewModel.outputs.showUserProfile = { [weak self] (user) in
            guard let self = self else { return }
            self.flowDelegate?.showProfile(forUser: user)
        }
    }
    
    private func reloadData(_ followers: [Follower]) { //TODO: we are not used the parameter
        print("user has \(followers.count) followers.")
        print(followers)
        collectionView.reloadData()
    }
}

// MARK: - Extensions (Delegation Conformance)

/// UICollectionViewDelegate Conformance
extension FollowersViewController: UICollectionViewDelegate {
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        cell.set(viewModel: viewModel.followers[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            //TODO: should I move this logic into the view model?
            guard viewModel.hasMoreFollowers, !viewModel.isLoadingMoreFollowers else { return }
            viewModel.page += 1
            viewModel.loadMoreFollowers()
        }
    }
    
    // handle user tap on follower list
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapUserProfileAt(indexPath: indexPath)
    }
}

extension FollowersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.followers.count
    }
}
