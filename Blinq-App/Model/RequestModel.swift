//
//  RequestModel.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation

struct RequestModel : Codable {
    var name: String
    var email: String
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case email = "email"
    }
}
