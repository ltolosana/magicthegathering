//
//  Environment.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 15/3/21.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    // swiftlint:disable all
    enum Keys {
        enum Plist {
            static let env = "APP_ENVIRONMENT"
            static let apiBaseURL = "API_BASE_URL"
        }
    }
    // swiftlint:enable all
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let appEnv: String = {
        guard let appEnvString = Environment.infoDictionary[Keys.Plist.env] as? String else {
            fatalError("APP Environment not set in plist for this environment")
        }
        return appEnvString
    }()
    
    static let appRootURL: URL = {
        guard let appRootURLString = Environment.infoDictionary[Keys.Plist.apiBaseURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: appRootURLString) else {
       fatalError("Root URL is invalid")
        }
        return url
    }()
}
