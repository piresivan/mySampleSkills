//
//  CashResponse.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 17/01/23.
//

import Foundation

struct CashResponse: Decodable {
    var title: String
    var bannerURL: String
    var description: String

    init(name: String, bannerURL: String, description: String) {
        self.title = name
        self.bannerURL = bannerURL
        self.description = description
    }

    enum CodingKeys: String, CodingKey {
        case title
        case bannerURL
        case description
    }
 }
