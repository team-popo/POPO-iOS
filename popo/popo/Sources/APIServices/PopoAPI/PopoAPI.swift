//
//  ConceptAPI.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation
import Moya

public class PopoAPI {
    
    static let shared = PopoAPI()
    var popoProvider = MoyaProvider<PopoService>()
    
    public init() { }
    
    func getPopoList(completion: @escaping (NetworkResult<Any>) -> Void) {
        popoProvider.request(.fetchPopoList) { (result) in
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
        guard let decodedData = try? decoder.decode(GenericResponse<[Concept]>.self, from: data)
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
