//
//  ChatroomsErrors.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 08/09/24.
//

public enum ChatroomsErrors: Error {
    case notFound
    case mandatoryMissing
    case internalError
    case unauthorized
    case parsingFailed
    case custom(error: String)
}
