//
//  ChatroomSocketService.swift
//  ChatMe
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import SocketIO
import RxSwift
import RxCocoa
import Models

public protocol ChatroomSocketApi {
    var socketResponse: Observable<ChatroomSockets.Response> { get }
    func login(email: String, username: String)
}


public class ChatroomSocketService {
    
    private let socketUrl: String
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    
    private let socketResponseRelay: PublishRelay<ChatroomSockets.Response> = PublishRelay()
    public lazy var socketResponse: Observable<ChatroomSockets.Response> = self.socketResponseRelay.asObservable()
    
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
        self.socketManager = SocketManager(socketURL: socketUrl)
        self.socket = self.socketManager.socket(forNamespace: "/")
        self.socket = self.socketManager.defaultSocket
        
        self.socket.connect()
        
        self.socket.on(ChatSocket.Response.loginResponse) { [weak self] (dataArray, socketAck) in
            print("Login sucessful for user: \(dataArray)")
            
            if let username = dataArray[0] as? String, let email = dataArray[1] as? String {
                self?.socketResponseRelay.accept(.loggedIn(username: username, email: email))
            }
        }
    }
}
