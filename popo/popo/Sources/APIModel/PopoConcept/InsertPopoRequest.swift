//
//  insertPopoRequest.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/18.
//

import Foundation

// MARK: - InsertPopoRequest

struct InsertPopoRequest: Codable {
    let category: Int
    let id: Int
    let options: [OptionRequest]
}


