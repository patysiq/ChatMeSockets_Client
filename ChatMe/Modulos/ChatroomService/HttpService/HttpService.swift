//
//  HttpService.swift
//  ChatroomService
//
//  Created by PATRICIA S SIQUEIRA on 07/09/24.
//

import Alamofire
import RxAlamofire
import RxSwift


public protocol HttpService {
    
    var session: Session { get }
    func request(_ urlequest: URLRequestConvertible) -> DataRequest
    
}

public protocol ReactiveHttpService: HttpService, ReactiveCompatible { }

extension Reactive where Base: ReactiveHttpService {
    
    public func request(_ urlRequest: URLRequestConvertible) -> Observable<DataRequest> {
        return base.session.rx
            .request(urlRequest: urlRequest)
    }
}
