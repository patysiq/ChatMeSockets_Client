//
//  Member.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 10/09/24.
//

import Foundation
import Utility


// MARK: - Member

public struct Member: Codable {
    public let role: Role
    public let email, id: String
}

// MARK: Members convenience initializers and mutators

public extension Member {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Member.self, from: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
