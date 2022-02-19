//
//  CategoryTableViewCell.swift
//  NewsApp
//
//  Created by Ahmed on 16/02/2022.
//

import UIKit

protocol CategoryTableViewCellProtocol {
    func display(_ model: CategoriesViewModel)
}
class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.applySketchShadow(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
        }
    }
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
    }
    
}

extension CategoryTableViewCell: CategoryTableViewCellProtocol {
    func display(_ model: CategoriesViewModel) {
        categoryNameLabel.text = model.category
        checkMarkImageView.image = model.isSelected ?  #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "outlinee")
    }
}
