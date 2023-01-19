//
//  ViewController.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 15/01/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    private var storeFetch: StoreResponse?
    private var api = RequestAPI()

    var isUnitTesting: Bool = false
    var isUITesting: Bool = false

    @IBOutlet weak var storeCollectionView: UICollectionView!
    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var prodFirstImage: UIImageView!
    @IBOutlet weak var prodMiddleImage: UIImageView!
    @IBOutlet weak var prodLastImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.storeCollectionView.dataSource = self
        self.storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
        getStore()
        getClickButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    fileprivate func getClickButtons() {
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bannerClick(tapGestureRecognizer:)))
        bannerImageView.isUserInteractionEnabled = true
        bannerImageView.addGestureRecognizer(tapGestureRecognizer)

        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(prodFirstClick(tapGestureRecognizer:)))
        prodFirstImage.isUserInteractionEnabled = true
        prodFirstImage.addGestureRecognizer(tapGestureRecognizer)

        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(prodSecondClick(tapGestureRecognizer:)))
        prodMiddleImage.isUserInteractionEnabled = true
        prodMiddleImage.addGestureRecognizer(tapGestureRecognizer)
    }

    func getStore() {
        if isUnitTesting || isUITesting {
            api.fetchFromMock {[weak self] modelResult in
                self?.storeFetch = modelResult
                DispatchQueue.main.async {
                    self?.storeCollectionView.reloadData()
                }
            }
        } else {
            api.fetchFromMock {[weak self] modelResult in
                self?.storeFetch = modelResult
                self?.bannerImageView.loadFrom(URLAddress: modelResult.cash.bannerURL)
                self?.prodFirstImage.loadFrom(URLAddress: modelResult.products[0].imageURL)
                self?.prodMiddleImage.loadFrom(URLAddress: modelResult.products[1].imageURL)
                self?.prodLastImage.loadFrom(URLAddress: modelResult.products[2].imageURL)
                DispatchQueue.main.async {
                    self?.storeCollectionView.reloadData()
                }
            }
        }
    }

    @objc
    func bannerClick(tapGestureRecognizer: UITapGestureRecognizer) {
        self.presentView(title: storeFetch?.cash.title ?? "", description: storeFetch?.cash.description ?? "", image: storeFetch?.cash.bannerURL ?? "")
    }

    @objc
    func prodFirstClick(tapGestureRecognizer: UITapGestureRecognizer) {
        self.presentView(title: storeFetch?.products[0].name ?? "", description: storeFetch?.products[0].description ?? "", image: storeFetch?.products[0].imageURL ?? "")
    }

    @objc
    func prodSecondClick(tapGestureRecognizer: UITapGestureRecognizer) {
        self.presentView(title: storeFetch?.products[1].name ?? "", description: storeFetch?.products[1].description ?? "", image: storeFetch?.products[1].imageURL ?? "")
    }

    fileprivate func presentView(title: String, description: String, image: String) {
        guard let nvc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        nvc.bannerImage = image
        nvc.descriptionInformation = description
        nvc.titleInformation = title
        self.present(nvc, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = storeFetch?.spotlight {
            return items.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as? ProductsCollectionViewCell {
            let spotlight = storeFetch?.spotlight[indexPath.item]
            cell.product = spotlight
            cell.backgroundColor = UIColor.black
            cell.layer.borderWidth = 1
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowRadius = 2.0
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2000, height: 40)
            cell.layer.shadowRadius = 2.0
            return cell
        } else {
            return ProductsCollectionViewCell()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presentView(
            title: storeFetch?.spotlight[indexPath.item].name ?? "",
            description: storeFetch?.spotlight[indexPath.item].description ?? "",
            image: storeFetch?.spotlight[indexPath.item].bannerURL ?? "")
    }
}
