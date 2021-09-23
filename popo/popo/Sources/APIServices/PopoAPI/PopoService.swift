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
//    case insertPopo(popoID: Int)
//    case deletePopo(popoID: Int)
//    case changeBackground(popoID: Int)
}

extension PopoService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchPopoList:
            return ""
//        case .setDefaultPopo:
//            return ""
//        case .insertPopo(popoID: let popoID):
//            return "/\(popoID)"
//        case .deletePopo(popoID: let popoID):
//            return "/\(popoID)"
//        case .changeBackground(popoID: let popoID):
//            return "/popo/\(popoID)/background"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopoList:
            return .get
//        case .setDefaultPopo:
//            return .post
//        case .insertPopo:
//            return .post
//        case .deletePopo:
//            return .delete
//        case .changeBackground:
//            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPopoList:
            return .requestPlain
//        case .setDefaultPopo:
//            return
//        case .insertPopo(popoID: let popoID):
//            retrun
//        case .deletePopo(popoID: let popoID):
//            return
//        case .changeBackground(popoID: let popoID):
//            return
        }
    }
    
    var headers: [String: String]? {
        switch self {
            
        case .fetchPopoList:
            return ["Content-Type": "application/json"]
//        case .setDefaultPopo:
//            return ["Content-Type" : "multipart/form-data"]
//        case .insertPopo:
//            return ["Content-Type" : "application/json"]
//        case .deletePopo:
//            return ["Content-Type" : "application/json"]
//        case .changeBackground:
//            return ["Content-Type" : "application/json"]
        }
    }
}
