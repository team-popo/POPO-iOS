//
//  TodayAPI.swift
//  popo
//
//  Created by kimhyungyu on 2021/10/21.
//

import Foundation
import Moya

public class TodayAPI {
    
    static let shared = TodayAPI()
    var popoProvider = MoyaProvider<TodayService>(plugins: [NetworkLoggerPlugin()])
    
    public init() { }
    
    func getTodayFetch(popoID: Int, dayID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        popoProvider.request(.todayFetch(popoID: popoID, dayID: dayID)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PopoToday>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
