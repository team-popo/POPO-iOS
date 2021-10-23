//
//  TempAPI.swift
//  popo
//
//  Created by kimhyungyu on 2021/09/23.
//

import Foundation
import Moya

public class TrackerAPI {
    
    static let shared = TrackerAPI()
    var trackerProvider = MoyaProvider<TrackerService>()
    
    public init() { }
    
    func getPopoList(popoId: Int,
                     year: Int,
                     month: Int,
                     completion: @escaping (NetworkResult<Any>) -> Void) {
        
        trackerProvider.request(.getTracker(popoId: popoId,
                                            year: year,
                                            month: month)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetPopoListStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchBackgroundImage(popoId: Int, image: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        trackerProvider.request(.patchBackgroundImage(popoID: popoId, backgroundImage: image)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetPopoListStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
        
    }
    
    private func judgeGetPopoListStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<TrackerData>.self, from: data)
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
