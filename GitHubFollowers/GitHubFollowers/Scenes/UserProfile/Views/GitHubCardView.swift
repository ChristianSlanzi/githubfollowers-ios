//
//  GitHubCardView.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 28.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class GitHubCardView: UIView {
    
    // MARK: - Properties

    let stackView = UIStackView()
    let itemInfoViewOne = ItemInfoView()
    let itemInfoViewTwo = ItemInfoView()
    let actionButton = UIButton()
    
    public init() {
        super.init(frame: .zero)
        setupViews()
        setupCostraints()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCostraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 18
        backgroundColor = .secondarySystemBackground
        
        itemInfoViewOne.set(itemInfoType: .followers, withCount: 0)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: 0)
        actionButton.setTitle("Git Followers", for: .normal)
        actionButton.backgroundColor = .systemGreen
                
        // TODO: move in a common card component
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
        addSubviews(stackView, actionButton)
        
        
    }
    
    private func setupCostraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)

        ])
    }

}
