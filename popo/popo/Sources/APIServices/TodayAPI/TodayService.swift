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
    case todayPatch(popoID: Int, dayID: Int, contentsID: Int)
}

extension TodayService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.popoURL)!
    }
    
    var path: String {
        switch self {
        case .todayFetch(let popoID, let dayID):
            return "/\(popoID)/tracker/\(dayID)"
        case .todayPatch(let popoID, let dayID, let contentsID):
            return "/\(popoID)/tracker/\(dayID)/contents/\(contentsID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .todayFetch:
            return .get
        case .todayPatch:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .todayFetch:
            return .requestPlain
        case .todayPatch:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .todayFetch:
            return .none
        case .todayPatch:
            return ["Content-Type": "application/json"]
        }
    }
}
