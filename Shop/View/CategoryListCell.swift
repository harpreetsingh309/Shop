//
//  CategoryListCell.swift
//  Shop
//
//  Created by Harpreet on 10/05/21.
//

import UIKit

class CategoryListCell: UITableViewCell {
    
    static let cellID = "categoryCell"

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryDescLabel: UILabel!
    @IBOutlet weak var itemWeightLabel: UILabel!
}
