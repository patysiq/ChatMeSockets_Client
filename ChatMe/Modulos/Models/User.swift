//
//  User.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import Foundation
import Utility

// MARK: - User

public struct User: Codable {
    public var email: String
    public var username, password: String?
}

public extension User {
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
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
}

