//
//  ChatroomsInteractor.swift
//  UseCases
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import RxSwift
import RxRelay
import ChatroomService
import Models

public final class ChatroomsInteractor {
   
    private let chatroomsRelay: BehaviorRelay<[Chatroom]> = BehaviorRelay(value: [])
    public lazy var chatrooms: Observable<[Chatroom]> = self.chatroomsRelay.asObservable()
    private let chatroomsService: ChatroomAPI
    
    init(chatroomsService: ChatroomAPI) {
        self.chatroomsService = chatroomsService
    }
}

public extension ChatroomsInteractor  {
    
    func fetchChatrooms() -> Completable {
        self.chatroomsService
            .chatrooms()
            .map({ [chatroomsRelay] (chatrooms) in
                chatroomsRelay.accept(chatroomsRelay.value + chatrooms)
            })
            .asCompletable()
    }
}

