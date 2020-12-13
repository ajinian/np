//
//  BatchButton.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/8/20.
//

import UIKit

class BadgeButton: UIButton {
    
    let badgeLabel: UILabel
    
    private var badgeNumber: Int = 0
    
    required init?(coder: NSCoder) {
        badgeLabel = UILabel(frame: CGRect(x: -20, y: 1, width: 20, height: 20))
        super.init(coder: coder)
        showBadge()
    }
    
    override init(frame: CGRect) {
        badgeLabel = UILabel(frame: CGRect(x: -20, y: 1, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        showBadge()
    }
    
    func increaseBatchNumber(by: Int) {
        badgeNumber += by
        badgeLabel.text = String(badgeNumber)
    }
    
    private func showBadge() {
        badgeLabel.layer.borderColor = UIColor.clear.cgColor
        badgeLabel.layer.borderWidth = 2
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
        badgeLabel.textAlignment = .center
        badgeLabel.layer.masksToBounds = true
        badgeLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor(displayP3Red: 1, green: 0.31, blue: 0.27, alpha: 1.0)
        badgeLabel.text = String(badgeNumber)
        addSubview(badgeLabel)
    }
}
