//
//  HomeViewModel.swift
//  Blinq-App
//
//  Created by Chirag Chaplot on 11/8/21.
//

import Foundation

class HomeViewModel {
    var request : SubmitInvitationRequestAPI
    var apiLoader : APILoader<SubmitInvitationRequestAPI>
    
    init() {
        request = SubmitInvitationRequestAPI()
        apiLoader = APILoader<SubmitInvitationRequestAPI>(apiHandler: request)
    }
    
    func submitInvitation(param: [String: Any], completion: @escaping (ResponseModel?, ServiceError?) -> ()) {
        apiLoader.loadAPIRequest(requestData: param) {
            (model, error) in
            if let error = error {
                print(error)
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}
