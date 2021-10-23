//
//  ConceptModel.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation

// MARK: - Concept

struct Concept: Codable {
    let id, category, order: Int
    let background: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case category, order, background
    }
}
