//
//  SpotlightResponse.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 17/01/23.
//

import Foundation

struct SpotlightResponse: Decodable {
    var name: String
    var bannerURL: String
    var description: String

    init(name: String, bannerURL: String, description: String) {
        self.name = name
        self.bannerURL = bannerURL
        self.description = description
    }

    enum CodingKeys: String, CodingKey {
        case name
        case bannerURL
        case description
   }
}
