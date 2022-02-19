//
//  CountryCollectionViewCell.swift
//  NewsApp
//
//  Created by Ahmed on 16/02/2022.
//

import UIKit

protocol CountryCollectionViewCellProtocol {
    func display(item: String, isSelected: Bool)
}

class CountryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.applySketchShadow(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
        }
    }
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


extension CountryCollectionViewCell: CountryCollectionViewCellProtocol {
    func display(item: String, isSelected: Bool) {
        countryNameLabel.text = item
        containerView.backgroundColor = isSelected ? .mainColor : .white
    }
}
