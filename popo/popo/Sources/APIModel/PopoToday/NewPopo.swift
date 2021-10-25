//
//  newPopo.swift
//  popo
//
//  Created by 초이 on 2021/10/25.
//

import Foundation
import UIKit

// MARK: - newPopo
struct NewPopo: Codable {
    let id: Int
    let date: String
    let options: [NewPopoOption]
}

// MARK: - newPopoOptions

struct NewPopoOption: Codable {
    let optionId: Int
    let contents: String
}
