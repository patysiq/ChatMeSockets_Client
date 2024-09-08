//
//  AccountHttpRouter.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 07/09/24.
//

import Alamofire
import Models

public enum AccoutHttpRouter {
    case login(user: User)
    case singUp(user: User)
}

extension AccoutHttpRouter: ReactiveHttpRouter {
    
    public var baseUrlString: String {
        return "http://localhost:3000"
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/login"
        case .singUp:
            return "/singUp"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        return .post
    }
    
    public var headers: Alamofire.HTTPHeaders? {
        return ["Content-Type" : "application/json"]
    }
    
    public func body() throws -> Data? {
        switch self {
        case .login(let user):
            return try user.jsonData()
        case .singUp(let user):
            return try user.jsonData()
        }
    }
}
