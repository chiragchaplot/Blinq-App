//
//  SubmitInvitationRequestAPI.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation

class SubmitInvitationRequestAPI: APIHandler {
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        if let name = param["name"] as? String, let email = param["email"] as? String {
            let param2 : [String: String] = ["name":name,"email":email]
            let jsonData2 = try? JSONSerialization.data(withJSONObject: param2)
            let urlString =  APIPath().fakeAuth
            if let url = URL(string: urlString) {
                var urlRequest = URLRequest(url: url)
                setDefaultHeaders(request: &urlRequest)
                urlRequest.httpBody = jsonData2
                urlRequest.httpMethod = HTTPMethod.post.rawValue
                return urlRequest
            }
        }

        return nil
    }

    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseModel {
        if response.statusCode == 200 {
            return ResponseModel(errorMessage: "Registered")
        } else if response.statusCode == 400 {
            let errorMessage =  try parseError(data: data, response: response)
            let defaults = UserDefaults.standard
            defaults.setValue(errorMessage, forKey: "error")
            throw ServiceError(httpStatus: response.statusCode, message: errorMessage)
        }
        else {
            return try defaultParseResponse(data: data,response: response)
        }
    }
    
    func parseError(data: Data, response: HTTPURLResponse) -> String{
        do {    let errorModel = try JSONDecoder().decode(ResponseModel.self, from: data)
            return errorModel.errorMessage
        }
        catch {
            return "Unknown Error"
        }
            
        
    }
}
