//
//  APIProvider.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya
import Foundation

class APIProvider<T: APITarget> {
    
    private lazy var provider = MoyaProvider<T>(
        endpointClosure: { $0.endPoint },
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )
    
    func request(target: T, completion: @escaping Completion) {
        provider.request(target) { [weak self] result in
            switch result {
            case let .success(response):
                self?.handleResponse(response, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleResponse(_ response: Response, completion: @escaping Completion) {
        guard (200...299).contains(response.statusCode) else {
            return completion(.failure(MoyaError.statusCode(response)))
        }
        completion(.success(response))
    }
}
