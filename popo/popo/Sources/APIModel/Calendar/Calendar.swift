//
//  Tracker.swift
//  popo
//
//  Created by 초이 on 2021/10/01.
//

import Foundation

// MARK: - Calendar

struct Calendar: Codable {
    let category: Int
    let tracker: [Tracker]
}
