//
//  User.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import Foundation

public struct User {
    
    public let email: String
    public let username: String
    
    init(email: String, username: String) {
        self.email = email
        self.username = username
    }
    
}
