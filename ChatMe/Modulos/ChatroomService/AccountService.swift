//
//  AccountService.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 08/09/24.
//

import Foundation
import RxSwift
import Models

public protocol AccoutAPI {
    func login(email: String, password: String) -> Single<User>
}

public final class AccountService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    public init() {}
}

extension AccountService: AccoutAPI{
    
    public func login(email: String, password: String) -> Single<User> {
        
        
        /// TODO - Error handling for login failure cases
        
          try! AccoutHttpRouter
            .login(user: User(email: email, password: password))
            .rx.request(withService: httpService)
            .responseJSON()
            .map { (result) -> User in
                guard let data = result.data else {
                    throw ChatroomsErrors.notFound
                }
                
                if result.response?.statusCode == 200 {
                    let authResponse = try User(data: data)
                    print(authResponse)
                    return authResponse
                } else {
                    throw ChatroomsErrors.internalError
                }
            }
            .asSingle()
    }
    
}
