//
//  FollowersCardView.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class FollowersCardView: UIView {
    
    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .systemBackground
    }
}
