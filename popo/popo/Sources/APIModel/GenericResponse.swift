//
//  GenericResponse.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var code: Int
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
        code = (try? values.decode(Int.self, forKey: .code)) ?? 0
    }
}
