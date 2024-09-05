//
//  AccountInteractor.swift
//  UseCases
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import RxSwift
import ChatroomService

public final class AccountInteractor {
    
    private let websocket: ChatroomSocketApi
    
    init(websocket: ChatroomSocketApi) {
        self.websocket = websocket
    }
    
}

public extension AccountInteractor {
    
    func login(username: String, email: String) -> Single<()>{
        self.websocket.login(email: email, username: username)
        return .never()
    }
}
