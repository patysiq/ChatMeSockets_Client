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
    func signUp(user: User) -> Single<User>
}

public final class AccountService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    public init() {}
}

extension AccountService: AccoutAPI {
    
    public func login(email: String, password: String) -> Single<User> {

          return AccoutHttpRouter
            .login(user: User(email: email, password: password))
            .rx.request(withService: httpService)
            .responseJSON()
            .map ({ (dataResponse) -> User in
                guard let data = dataResponse.data else {
                    throw ChatroomsErrors.notFound(message: email)
                }
                if dataResponse.response?.statusCode == 200 {
                    do { return try User.init(data: data) } catch {
                        throw ChatroomsErrors.parsingFailed
                    }
                } else {
                    throw ChatroomsErrors.unauthorized(message: email)
                }
            })
            .asSingle()
    }
    
    public func signUp(user: User) -> Single<User> {
        return AccoutHttpRouter
                .singUp(user: user)
                .rx.request(withService: httpService)
                .responseJSON()
                .map({ (dataResult) -> User in
                    guard let data = dataResult.data else {
                        throw ChatroomsErrors.notFound(message: user.email)
                    }
                    
                    if dataResult.response?.statusCode == 200 {
                        do { return try User.init(data: data) } catch {
                            throw ChatroomsErrors.parsingFailed
                        }
                    }
                    throw ChatroomsErrors.unauthorized(message: user.email)
                })
                .asSingle()
        
    }
    
}
