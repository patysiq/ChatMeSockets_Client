//
//  ChatroomSocketService.swift
//  ChatMe
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import SocketIO

public protocol ChatroomSocketApi {
    func login(email: String, username: String)
}


public class ChatroomSocketService {
    
    private let socketUrl: String
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    
    public init(socketURl: String) {
        self.socketUrl = socketURl
        setup(usingSocketUrl: URL(string: self.socketUrl)!)
    }
    
    deinit {
        self.socket.disconnect()
    }
}

extension ChatroomSocketService: ChatroomSocketApi {

    
    public func login(email: String, username: String) {
        print("Login request receive for username \(username) and email \(email)")
        self.socket.emit(ChatSocket.Request.login, username, email)
    }
}

struct ChatSocket {
    
    struct Request {
        static let login = "login"
    }
    
    struct Response {
        static let loginResponse = "loginResponse"
    }
}

private extension ChatroomSocketService {
    
    func setup(usingSocketUrl socketUrl: URL) {
        self.socketManager = SocketManager(socketURL: socketUrl, config: [.log(true), .compress])
        self.socket = self.socketManager.socket(forNamespace: "/")
        self.socket = self.socketManager.defaultSocket

        
        self.socket.connect()
        
        self.socket.on(ChatSocket.Response.loginResponse) { (dataArray, socketAck) in
            print("Login sucessful for user: \(dataArray)")
        }
    }
}
