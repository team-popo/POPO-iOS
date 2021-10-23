//
//  Option.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/21.
//

import Foundation

// MARK: - Option

struct Option: Codable {
    let id: Int
    let name, contents: String
    let type, order: Int
}
