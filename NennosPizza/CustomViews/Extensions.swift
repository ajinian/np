//
//  Extensions.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/6/20.
//

import UIKit

extension UIViewController {
    func setLeftAlignedNavigationItemTitle(text: String) {
        let titleLabel = UILabel ()
        titleLabel.textColor = UIColor(displayP3Red: 1, green: 0.31, blue: 0.27, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        titleLabel.numberOfLines = 0
        titleLabel.center = CGPoint(x: 0, y: 0)
        titleLabel.textAlignment = .left
        titleLabel.text = text
        navigationItem.titleView = titleLabel
        guard let containerView = navigationController?.navigationBar else { return }
        let leftBarItemWidth = navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: leftBarItemWidth ?? 32)
        ])
    }
}
