//
//  BatchButton.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/8/20.
//

import UIKit

class BatchButton: UIButton {
    
    private let label = UILabel(frame: CGRect(x: -25, y: 1, width: 20, height: 20))
    private var batchNumber: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func showBatch() {
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.backgroundColor = UIColor(displayP3Red: 1, green: 0.31, blue: 0.27, alpha: 1.0)
        label.text = String(batchNumber)
        addSubview(label)
    }
    
    func increaseBatchNumber(by: Int) {
        batchNumber += by
        label.text = String(batchNumber)
    }
}
