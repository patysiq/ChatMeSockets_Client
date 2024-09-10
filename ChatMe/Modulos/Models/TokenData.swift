//
//  TokenData.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import Utility

public struct TokenData: Codable {
    public let email, acessToken, refreshToken: String
    public let expiresIn: Int64
    
    public init(email: String, acessToken: String, refreshToken: String, expiresIn: Int64) {
        self.email = email
        self.acessToken = acessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
}

public extension TokenData {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TokenData.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(from url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    func with(email: String? = nil, acessToken: String? = nil, refreshToken: String? = nil, expiresIn: Int? = nil) {
        
    }
}

