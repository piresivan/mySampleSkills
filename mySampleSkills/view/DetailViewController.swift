//
//  DetailViewController.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 19/01/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var titleInformation: String?
    var descriptionInformation: String?
    var bannerImage: String?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var promotionImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleInformation
        descriptionLabel.text = descriptionInformation
        promotionImageView.loadFrom(URLAddress: bannerImage ?? "")
    }
}
