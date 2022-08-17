//
//  NetworkInterceptor.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 15/08/2022.
//

import Foundation
import Alamofire

class NetworkInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if AppCoordinator.userMode == .authenticated {
            let token = AuthenticationModule.shared.fetchBearerToken()
            var adaptedRequest = urlRequest
            adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            completion(.success(adaptedRequest))
        }
        else {
            completion(.success(urlRequest))
        }
    }
}
