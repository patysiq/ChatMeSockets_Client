//
//  ChatroomHttpRouter.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Alamofire


enum ChatroomsHttpRouter {
    case chatrooms
}

extension ChatroomsHttpRouter: ReactiveHttpRouter {
    
    private var acessToken: String {
        return UserSettingsService.shared.acessToken
    }
    
    var baseUrlString: String {
        return "http://localhost:3000"
    }
    
    var path: String {
        switch self {
        case .chatrooms:
            return "/chatrooms"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .chatrooms:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return ["Content-Type" : "application/json",
                "Authorization" : "Bearer \(acessToken)"]
    }
}
