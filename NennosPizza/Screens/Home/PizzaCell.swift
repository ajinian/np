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
    @IBOutlet weak var priceTagView: UIView!
    @IBOutlet weak var priceTagLabel: UILabel!
    
    override func awakeFromNib() {
        priceTagView.layer.cornerRadius = 6.0;
        priceTagView.layer.borderColor = UIColor.black.cgColor
        priceTagView.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        pizzaImage.image = UIImage(named: "pizza_placeholder")
    }
}
