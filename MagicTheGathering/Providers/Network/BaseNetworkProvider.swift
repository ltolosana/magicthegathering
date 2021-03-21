//
//  BaseNetworkProvider.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 18/3/21.
//

import Foundation
import Alamofire

/// Network errors
enum NetworkError: Error, LocalizedError {
    case generic(String)
    case badResponse
    case badData

    /// Localized description
    var localizedDescription: String {
        switch self {
        case .generic(let localizableDescription):
            return localizableDescription
        case .badResponse:
            return "network_error_parsing_description"
        case .badData:
            return "network_error_bad_data"
        }
    }
}

// MARK: - Class
class BaseNetworkProvider {
    
    /// Main session manager
    var sessionManager: Session = {
        // Create the server trust policies
        let server = Environment.appRootURL.absoluteString
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            server: PinnedCertificatesTrustEvaluator(certificates: [],
                                                      acceptSelfSignedCertificates: false,
                                                      performDefaultValidation: true,
                                                      validateHost: true),
            "selfsignedserver.com": DisabledTrustEvaluator()
        ]

        // Create custom manager
        var configuration = URLSessionConfiguration.af.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = NetworkConstants.kTimeoutIntervalForRequest
        configuration.timeoutIntervalForResource = NetworkConstants.kTimeoutIntervalForResource
        configuration.httpMaximumConnectionsPerHost = 2

        let manager = ServerTrustManager(evaluators: serverTrustPolicies)
        let session = Session(configuration: configuration)

        return session
    }()
}
