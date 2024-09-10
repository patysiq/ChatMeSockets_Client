//
//  Chatroom.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import Utility

public typealias Chatrooms = [Chatroom]

public extension Array where Element == Chatrooms.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chatrooms.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
