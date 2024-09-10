//
//  UserSettingsService.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import Models

public protocol UserSettingsAPI {
    var acessToken: String { get }
    var refreshToken: String { get }
    func saveTokens(tokenData: TokenData)
    func getTokens() -> TokenData
    func clearTokens()
}

public final class UserSettingsService {
    
    private let EMAIL: String = "EMAIL"
    private let ACESS_TOKEN: String = "ACESS_TOKEN"
    private let REFRESH_TOKEN: String = "REFRESH_TOKEN"
    private let EXPIRE_IN: String = "EXPIRE_IN"
    private let userDefaults = UserDefaults.standard
    
    
    public static var shared: UserSettingsService = UserSettingsService()
    
    init() {
        
    }
    
}

extension UserSettingsService: UserSettingsAPI {
    
    public var acessToken: String {
        return userDefaults.string(forKey: ACESS_TOKEN) ?? ""
    }
    
    public var refreshToken: String {
        return userDefaults.string(forKey: REFRESH_TOKEN) ?? ""
    }
    
    public func saveTokens(tokenData: TokenData) {
        userDefaults.set(tokenData.email, forKey: EMAIL)
        userDefaults.set(tokenData.acessToken, forKey: ACESS_TOKEN)
        userDefaults.set(tokenData.refreshToken, forKey: REFRESH_TOKEN)
        userDefaults.set(tokenData.expiresIn, forKey: EXPIRE_IN)
    }
    
    public func getTokens() -> TokenData {
        let email = userDefaults.string(forKey: EMAIL) ?? ""
        let acessToken = userDefaults.string(forKey: ACESS_TOKEN) ?? ""
        let refreshToken = userDefaults.string(forKey: REFRESH_TOKEN) ?? ""
        let expireIn = Int64(userDefaults.integer(forKey: EXPIRE_IN))
        
        return TokenData(email: email,
                         acessToken: acessToken,
                         refreshToken: refreshToken,
                         expiresIn: expireIn)
    }
    
    public func clearTokens() {
        userDefaults.removeObject(forKey: EMAIL)
        userDefaults.removeObject(forKey: ACESS_TOKEN)
        userDefaults.removeObject(forKey: REFRESH_TOKEN)
        userDefaults.removeObject(forKey: EXPIRE_IN)
    }
}
