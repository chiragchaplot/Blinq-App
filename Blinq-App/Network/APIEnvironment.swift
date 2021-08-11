//
//  APIEnvironment.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return domain()
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "https://us-central1-blinkapp-684c1.cloudfunctions.net/"
        case .staging:
            return "https://us-central1-blinkapp-684c1.cloudfunctions.net/"
        case .production:
            return "https://us-central1-blinkapp-684c1.cloudfunctions.net/"
        }
    }
}
