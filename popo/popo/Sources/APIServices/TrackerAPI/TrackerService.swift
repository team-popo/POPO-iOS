//
//  TrackerService.swift
//  popo
//
//  Created by 초이 on 2021/10/23.
//

import Foundation
import Moya

enum TrackerService {
    case getTracker(popoId: Int, year: Int, month: Int)
}

extension TrackerService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.popoURL)!
    }
    
    var path: String {
        switch self {
        case .getTracker(let popoId, _, _):
            return "\(popoId)/tracker"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTracker(_, _, _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getTracker(_, let year, let month):
            return .requestParameters(parameters: [
                "year": year,
                "month": month
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getTracker(_, _, _):
            return [
                "Content-Type": "application/json",
                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImlhdCI6MTYyOTExMjcyNCwiZXhwIjoxNjMxNzA0NzI0LCJpc3MiOiJmb3J0aWNlIn0.CkrwwZe7sJ9RxLbkbbeIz-w4fs2AkQ-FrERDcZNQI2E"
            ]
        }
    }
}
