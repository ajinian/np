//
//  CheckboxButton.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class CheckBox: UIButton {
    
    let checkedImage = UIImage(named: "checkbox")

    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
                self.backgroundColor = UIColor(displayP3Red: 1, green: 0.31, blue: 0.27, alpha: 1.0)
                layer.borderWidth = 0
            } else {
                self.setImage(nil, for: .normal)
                self.backgroundColor = .white
                layer.borderWidth = 2
            }
        }
    }

    override func awakeFromNib() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 3
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

extension Reactive where Base: CheckBox {
    var isChecked: Binder<Bool> {
        return Binder(self.base) { button, isChecked in
            button.isChecked = isChecked
        }
    }
}
