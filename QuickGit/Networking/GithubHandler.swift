//
//  GithubHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import Foundation
import Alamofire

class GitHubHandler {
    func handleRequest<DataModelType: Decodable>(using endpoint: GitHubEndPoint, parameters: [String: String], headers: HTTPHeaders?) async throws -> DataModelType {
//        print(endpoint.targetURL)
//        let string = try await AF.request("\(endpoint.targetURL)?q=repos:%3E42+followers:%3E1000", method: .get, headers: headers).serializingString().value
//        print(string)
        let data =  try await AF.request("\(endpoint.targetURL)?q=repos:%3E42+followers:%3E1000", method: .get, headers: headers).serializingDecodable(DataModelType.self).value
        return data
    }
}
