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
        
        let queryParams = parameters ?? endpoint.defaultParameters
        
        let dataRequest = session.request("\(endpoint.targetURL)", method: .get, parameters: queryParams, encoder: parameterEncoder)
        let dataTask = dataRequest.serializingDecodable(DataModelType.self)
        
        let data =  try await dataTask.value
        
        return data
    }
}
