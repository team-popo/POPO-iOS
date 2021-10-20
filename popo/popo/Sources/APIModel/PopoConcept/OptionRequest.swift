//
//  OptionRequest.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/21.
//

import Foundation

// MARK: - OptionRequest

struct OptionRequest: Codable {
    let name: String
    let order: Int
    let type: Int
}
