//
//  APITarget.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya
import Foundation

protocol APITarget: TargetType {
    var endPoint: Endpoint { get }
}

extension APITarget {
    var sampleData: Data { Data() }
    var baseURL: URL { APIHost.baseURL }
    var apiKey: String { APIHost.apiKey }
    var headers: [String: String]? { nil }
    var task: Task { .requestPlain }
    
    var endPoint: Endpoint {
        Endpoint(
            url: "\(baseURL)\(path)",
            sampleResponseClosure: { .networkResponse(200, self.sampleData) },
            method: method,
            task: taskWithAPIKey(),
            httpHeaderFields: headers
        )
    }
    
    private func taskWithAPIKey() -> Task {
        switch task {
        case .requestPlain:
            return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.default)
        case .requestParameters(var parameters, let encoding):
            parameters["api_key"] = apiKey
            return .requestParameters(parameters: parameters, encoding: encoding)
        default:
            return task
        }
    }
}
