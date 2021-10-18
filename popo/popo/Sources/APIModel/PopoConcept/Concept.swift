//
//  ConceptModel.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation

struct Concept: Codable {
    let identifier, category, order: Int
    let background: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case category, order, background
    }
}
