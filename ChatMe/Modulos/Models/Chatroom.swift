//
//  Chatroom.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import Utility

public struct Chatroom: Codable {
    public let status: Bool
    public let members: [Member]
    public let messages: [Message]
    public let creator, name, subject, createdAt: String
    public let updateAt, id: String
}

// MARK: WelcomeElement convenience initializers and mutators

public extension Chatroom {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chatroom.self, from: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Chatroom : Equatable {
    
    public static func == (lsh: Chatroom , rsh: Chatroom) -> Bool {
        lsh.id == rsh.id
        
    }
}

extension Chatroom: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
