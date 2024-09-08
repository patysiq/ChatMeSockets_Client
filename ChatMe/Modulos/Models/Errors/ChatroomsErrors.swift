//
//  ChatroomsErrors.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 08/09/24.
//

public enum ChatroomsErrors: Error {
    case notFound(message: String)
    case mandatoryMissing
    case internalError
    case unauthorized(message: String)
    case parsingFailed
    case custom(error: String)
}

public extension ChatroomsErrors {
    
    var errorDescription: String? {
        switch self {
        case .notFound(let message): return "\(message) not found"
        case .mandatoryMissing: return "Mandatory parameters missing"
        case .internalError: return "Somenthing went wrong"
        case .unauthorized(let message): return "\(message) not authorized"
        case .parsingFailed: return "Somenthing went wrong while parsing"
        case .custom(let description): return description
        }
    }
}
