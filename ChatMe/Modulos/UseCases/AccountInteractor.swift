//
//  AccountInteractor.swift
//  UseCases
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import RxSwift
import ChatroomService
import Models
import RxRelay

public final class AccountInteractor {
    
    private let accountService: AccoutAPI
    private let userSettings: UserSettingsAPI
    private let userRelay: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    public lazy var user: Observable<User?> = self.userRelay.asObservable()
    
    init(accountService: AccoutAPI, userSettings: UserSettingsAPI) {
        self.accountService = accountService
        self.userSettings = userSettings
    }
    
}

public extension AccountInteractor {
    
    func login(email: String, password: String) -> Single<()> {
        self.accountService
            .login(email: email, password: password)
            .flatMap(saveUser(user:))
    }
        
        func signUp(email: String, username: String, password: String) -> Single<()> {
            self.accountService
                .signUp(user: User(email: email, username: username, password: password))
                .flatMap(saveUser(user:))
        }
        
//        self.websocketService.login(email: email, password: password)
//        
//        return self.websocketService.socketResponse
//                .debug("Login flow", trimOutput: false)
//                .filter({
//                    guard case .loggedIn = $0 else {return false}
//                    return true
//                })
//                .map {(result) -> User? in
//                    guard case .loggedIn(let email, let password) = result else {return nil}
//                    return User(email: email, password: password)
//                }
//                .take(1)
//                .flatMap(saveUser(user:))
//                .asSingle()
//                .do (onSubscribe: { [weak self] in
//                    self?.websocketService.login(email: email, password: password)
//                })
        
    
}

private extension AccountInteractor {
    
    func saveUser(user: User?) -> Single<()> {
        self.userRelay.accept(user)
        if let tokenData = user?.tokenData {
            self.userSettings.saveTokens(tokenData: tokenData)
        }
        return .just(())
    }
}
