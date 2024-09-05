//
//  UseCasesFactory.swift
//  UseCases
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import Foundation
import ChatroomService


public final class UseCasesFactory {
    
    private static let deployedUrl = "http://localhost:3000"
    private static let websocketservice = ChatroomSocketService(socketURl: deployedUrl)
    public static let accountsInteractor: AccountInteractor = AccountInteractor(websocketService: websocketservice)
}
