//
//  PizzaCell.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/5/20.
//

import UIKit

class PizzaCell: UICollectionViewCell {
    
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var priceButton: Button!
    
    override func prepareForReuse() {
        pizzaImage.image = UIImage(named: "pizza_placeholder")
    }
}
