//
//  Courses.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 17/01/23.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!

    var product: SpotlightResponse! {
        didSet {
            self.updateUI()
        }
    }

    func updateUI() {
        productImageView.loadFrom(URLAddress: product.bannerURL)
    }
}
