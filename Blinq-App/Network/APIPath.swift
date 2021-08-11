//
//  APIPath().swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.development
#endif

let baseURL = environment.baseURL()

struct APIPath {
        
    var fakeAuth: String {
        return "\(baseURL)fakeAuth"
    }
}
