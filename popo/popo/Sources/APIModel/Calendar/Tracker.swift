//
//  Tracker.swift
//  popo
//
//  Created by 초이 on 2021/10/01.
//

import Foundation

// MARK: - TrackerData
struct TrackerData: Codable {
    let category: Int
    let background: String
    let tracker: [Tracker]
}

// MARK: - Tracker
struct Tracker: Codable {
    let id, date: Int
    let image: String
}
