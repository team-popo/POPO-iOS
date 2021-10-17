//
//  ConceptModel.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation

struct Concept: Codable {
    let identifier, conceptID, category, order: Int
    let background: String
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case conceptID = "conceptId"
        case category, order, background
        case ownerID = "ownerId"
    }
}
