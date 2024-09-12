//
//  Chatroom.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import Utility

public typealias Chatrooms = [Chatroom]

public extension Chatrooms {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chatrooms.self, from: data)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

