//
//  ChatroomHttpService.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 07/09/24.
//

import Alamofire

public class ChatroomHttpService: ReactiveHttpService {
    
    public static let shared: ChatroomHttpService  = ChatroomHttpService()
    
    public var session: Session
    
    private init() {
        self.session = Session.default
    }
    
    public func request(_ urlequest: any URLRequestConvertible) -> DataRequest {
        self.session.request(urlequest)
    }
}
