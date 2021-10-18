//
//  insertPopoRequest.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/18.
//

import Foundation

struct InsertPopoRequest: Codable {
    let category: Int
    let id: Int
    let options: [Options]
}

struct Options: Codable {
    let name: String
    let order: Int
    let type: Int
}
