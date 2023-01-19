//
//  ProductsResponse.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 17/01/23.
//

import Foundation

struct ProductsResponse: Decodable {
    var name: String
    var imageURL: String
    var description: String

    init(name: String, imageURL: String, description: String) {
        self.name = name
        self.imageURL = imageURL
        self.description = description
    }

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL
        case description
    }
}
