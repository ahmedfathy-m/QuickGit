//
//  AuthenticationModule.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 15/08/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthenticationModule {
    private let baseURL = "https://github.com/login/oauth"
    private var isConfigured: Bool{
        if clientID == nil || clientSecret == nil {
            return false
        }
        return true
    }
    private var clientID: String?
    private var clientSecret: String?
    fileprivate var sessionCode: String? {
        didSet {
            Task {
                try await AuthenticationModule.shared.requestTokenFromServer()
                onAuthenticationCompletion?()
            }
        }
    }
    
    var onAuthenticationCompletion: (()->())?
    
    private var bearerToken = ""
    
    func fetchBearerToken() -> String {
        return bearerToken
    }
    
    static let shared = AuthenticationModule()
    
    func configure(client: String, secret: String) {
        self.clientID = client
        self.clientSecret = secret
    }
    
    func askForUserPermission(scope: OAuthScope) {
        if isConfigured {
            var permissionURL = "\(baseURL)/authorize?"
            permissionURL.append(scope.keyValParameter)
            permissionURL.append("&client_id=\(clientID!)")
            
            if let targetURL = URL(string: permissionURL) {
                UIApplication.shared.open(targetURL)
            }
        }
        else {
            print("Configure Credentials First")
        }
    }
    
    func requestTokenFromServer() async throws {
        guard isConfigured else { return }
        guard sessionCode != nil else { return }

        let tokenURL = "\(baseURL)/access_token"
        let parameters = ["client_id": clientID ?? "",
                          "client_secret": clientSecret ?? "",
                          "code": sessionCode ?? ""]
        let headers = HTTPHeaders(["Accept":"application/json"])
        let dataRequest = AF.request(tokenURL, method: .post, parameters: parameters,encoding: URLEncoding.queryString, headers: headers)
        let tokenData = try await dataRequest.serializingData().value
        let json = try JSON(data: tokenData)
        print(json)
        bearerToken = json["access_token"].string ?? ""
        print(bearerToken)
    }
}

extension SceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let url = (URLContexts.first?.url)!
        let comp = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let code = comp?.queryItems?.first?.value {
            AuthenticationModule.shared.sessionCode = code
        }
    }
}

enum OAuthScope: String {
    case user = "user"
    case userEmail = "user:email"
    
    private var keyVal: [String: String] {
        return ["scope": self.rawValue]
    }
    
    var keyValParameter: String {
        keyVal.map {"\($0):\($1)"}.joined(separator: "=")
    }
}
