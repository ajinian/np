//
//  Button.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/6/20.
//

import UIKit

class Button: UIButton {
    
    private var batchNumber: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    private func commontInit() {
        layer.cornerRadius = 6.0;
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
