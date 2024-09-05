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
    
    private let websocketService: ChatroomSocketApi
    
    private let userRelay: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    public lazy var user: Observable<User?> = self.userRelay.asObservable()
    
    init(websocketService: ChatroomSocketApi) {
        self.websocketService = websocketService
    }
    
}

public extension AccountInteractor {
    
    func login(username: String, email: String) -> Single<()>{
        self.websocketService.login(email: email, username: username)
        
        return self.websocketService.socketResponse
                .debug("Login flow", trimOutput: false)
                .filter({
                    guard case .loggedIn = $0 else {return false}
                    return true
                })
                .map {(result) -> User? in
                    guard case .loggedIn(let username, let email) = result else {return nil}
                    return User(email: email, username: username)
                }
                .take(1)
                .flatMap(saveUser(user:))
                .asSingle()
                .do (onSubscribe: { [weak self] in
                    self?.websocketService.login(email: email, username: username)
                })
        
    }
}

private extension AccountInteractor {
    
    func saveUser(user: User?) -> Single<()> {
        self.userRelay.accept(user)
        return .just(())
    }
}
