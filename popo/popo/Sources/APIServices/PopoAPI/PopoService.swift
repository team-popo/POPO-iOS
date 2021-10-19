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
    case changeBackground(popoID: Int, backgroundImage: UIImage)
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
        case .changeBackground(let popoID, _):
            return "\(popoID)/background"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopoList:
            return .get
        case .insertPopo:
            return .post
        case .changeBackground:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPopoList:
            return .requestPlain
        case .insertPopo(_, let parameter):
            return .requestJSONEncodable(parameter)
        case .changeBackground(_, let backgroundImage):
            if let backgroundImage = backgroundImage.jpegData(compressionQuality: 1.0) {
                return .uploadMultipart([MultipartFormData(provider: .data(backgroundImage), name: "image", fileName: "background.jpg", mimeType: "image/jpg")])
            }
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchPopoList:
            return .none
        case .insertPopo:
            return ["Content-Type": "application/json"]
        case .changeBackground:
            return ["Content-Type": "multipart/form-data"]
        }
    }
}
