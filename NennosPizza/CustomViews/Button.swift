//
//  Button.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/6/20.
//

import UIKit

class Button: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 6.0;
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }

}
