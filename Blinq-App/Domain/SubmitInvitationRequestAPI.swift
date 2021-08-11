//
//  SubmitInvitationRequestAPI.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation

class SubmitInvitationRequestAPI: APIHandler {
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        let urlString =  APIPath().fakeAuth
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpBody = jsonData
            urlRequest.httpMethod = HTTPMethod.post.rawValue
            return urlRequest
        }

        return nil
    }

    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
