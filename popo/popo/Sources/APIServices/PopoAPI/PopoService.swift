//
//  ConceptService.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation
import Moya

enum PopoService {
    case fetchPopoList
//    case setDefaultPopo
    case insertPopo(popoID: Int, parameter: InsertPopoRequest)
//    case deletePopo(popoID: Int)
}

extension PopoService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.popoURL)!
    }
    
    var path: String {
        switch self {
        case .fetchPopoList:
            return ""
        case .insertPopo(let popoID, _):
            return "/\(popoID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopoList:
            return .get
        case .insertPopo:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPopoList:
            return .requestPlain
        case .insertPopo(_, let parameter):
            return .requestJSONEncodable(parameter)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchPopoList:
            return .none
        case .insertPopo:
            return ["Content-Type": "application/json"]
        }
    }
}
