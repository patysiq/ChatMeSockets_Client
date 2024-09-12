//
//  Presenter.swift
//  Window
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//


import Foundation
import RxSwift
import RxCocoa

enum RouteTo {
    case login
    case singup
    case chatrooms
}

protocol Routing {
    func routeToLanding() -> Single<Void>
    func routeToLogin() -> Single<RouteTo>
    func routeToSignUp() -> Single<RouteTo>
    func routeToChatrooms() -> Single<Void>
}

class Presenter: Presentation {
    
    private let bag = DisposeBag()
    private let router: Routing
    private let routeToRelay: PublishRelay<RouteTo> = PublishRelay()
    private lazy var routeToDriver: Driver<RouteTo> = self.routeToRelay.asDriver(onErrorDriveWith: .never())
    
    init(router: Routing) {
        self.router = router
        process()
    }
}

private extension Presenter {
    
    func process() {
        
        self.router.routeToLanding()
            .flatMap(self.router.routeToLogin)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case .singup = $0 else { return false }
                return true
            })
            .map({ _ in () })
            .asObservable()
            .flatMap(self.router.routeToSignUp)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
            
    }
}
