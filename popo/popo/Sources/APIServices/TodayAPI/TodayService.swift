//
//  TodayService.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/21.
//

import Foundation
import Moya

enum TodayService {
    case todayFetch(popoID: Int, dayID: Int)
}

extension TodayService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.popoURL)!
    }
    
    var path: String {
        switch self {
        case .todayFetch(let popoID, let dayID):
            return "/\(popoID)/tracker/\(dayID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .todayFetch:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .todayFetch:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .todayFetch:
            return .none
        }
    }
}
