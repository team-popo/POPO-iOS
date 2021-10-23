//
//  TodayFetch.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/21.
//

import Foundation

// MARK: - PopoToday

struct PopoToday: Codable {
    let id: Int
    let date: String
    let image: String
    let options: [Option]
}

