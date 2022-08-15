//
//  GithubHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import Foundation
import Alamofire

class NetworkHandler {
    
    static let shared = NetworkHandler()
    let session = Session(interceptor: NetworkInterceptor())
    func loadRequest<DataModelType: Decodable>(using endpoint: GitHubEndPoint, parameters: [String: String]?, headers: HTTPHeaders?) async throws -> DataModelType {
        
        var allowedCharSet = CharacterSet.urlPathAllowed
        allowedCharSet.update(with: ":")
        let encoder = URLEncodedFormEncoder(allowedCharacters: allowedCharSet)
        let parameterEncoder = URLEncodedFormParameterEncoder(encoder: encoder, destination: .queryString)
        
        let queryParams = parameters ?? endpoint.params
        print(queryParams)
        
        let dataRequest = session.request("\(endpoint.targetURL)", method: .get, parameters: queryParams, encoder: parameterEncoder)
//        let dataRaw = try await dataRequest.serializingString().value
//        print(dataRaw)
        let data =  try await dataRequest.serializingDecodable(DataModelType.self).value
        
        print(dataRequest.request?.headers)
        
        return data
    }
}
