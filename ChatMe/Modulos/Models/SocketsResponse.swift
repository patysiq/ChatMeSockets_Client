//
//  SocketsResponse.swift
//  Models
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import Foundation


public enum ChatroomSockets {
    public enum Response {
        case loggedIn(username: String, email: String)
    }
}
