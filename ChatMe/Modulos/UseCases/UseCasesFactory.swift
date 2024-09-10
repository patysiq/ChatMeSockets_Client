//
//  UseCasesFactory.swift
//  UseCases
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import Foundation
import ChatroomService


public final class UseCasesFactory {
    
    private static let deployedUrl = "http://localhost:3001"
    //private static let websocketservice = ChatroomSocketService(socketURl: deployedUrl)
    private static let accountService = AccountService()
    private static let userSettings = UserSettingsService.shared
    private static let chatroomsService = ChatroomsService.shared
    public static let chatroomsInteractor: ChatroomsInteractor = ChatroomsInteractor(chatroomsService: chatroomsService)
    public static let accountsInteractor: AccountInteractor = AccountInteractor(accountService: accountService, userSettings: userSettings)
    
}
