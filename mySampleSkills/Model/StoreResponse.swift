//
//  StoreResponse.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 17/01/23.
//

import Foundation

struct StoreResponse: Decodable {
    var spotlight: [SpotlightResponse]
    var products: [ProductsResponse]
    var cash: CashResponse

    init(spotlight: [SpotlightResponse], products: [ProductsResponse], cash: CashResponse) {
        self.spotlight = spotlight
        self.products = products
        self.cash = cash
   }

   enum CodingKeys: String, CodingKey {
       case spotlight
       case products
       case cash
   }
}
