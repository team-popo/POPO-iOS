//
//  TrackerOptions.swift
//  popo
//
//  Created by 초이 on 2021/10/25.
//

import Foundation

// MARK: - TrackerOptions

struct TrackerOptions: Codable {
    let id: Int
    let name: String
    let type, order: Int
}
