//
//  ChatroomsService.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import RxSwift
import Models

public protocol ChatroomAPI {
    func chatrooms() -> Single<[Chatroom]>
}

public final class ChatroomsService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    public static let shared: ChatroomsService = ChatroomsService()
    private init() {}
    
}

extension ChatroomsService: ChatroomAPI {
    
    public func chatrooms() -> Single<[Chatroom]> {
        ChatroomsHttpRouter.chatrooms.rx
            .request(withService: httpService)
            .responseJSON()
            .map { (dataResponse) in
                
                if let eroor = dataResponse.error {
                    print(eroor)
                    throw ChatroomsErrors.custom(error: eroor.localizedDescription)
                }
                
                guard
                    let statusCode = dataResponse.response?.statusCode,
                    statusCode == 200,
                    let data = dataResponse.data else {
                    throw ChatroomsErrors.notFound(message: "Chatroom not exist.")
                }
                return try Chatrooms.init(data: data)
            }
            .asSingle()
    }
    
    
}
