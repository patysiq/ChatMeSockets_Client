//
//  Presenter.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import Models
import RxDataSources

protocol Presentation {
    
    typealias Input = ()
    typealias Output = (
        sections: Driver<[ChatroomsSection]>, ()
    )
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    var output: Output { get }
}

class Presenter : Presentation {
    
    var input: Input
    var output: Output
    
    typealias UseCases = (
        input: (
            fetchChatrooms: () -> Completable, ()
        ),
        output: (
            chatrooms: Observable<Set<Chatroom>>, ()
        )
    )
    private let bag = DisposeBag()
    private let dependencias: Dependencias
    private let useCases: UseCases
    private let router: Routing
    
    typealias Dependencias = (router: Routing, useCases: UseCases)
    
    init(input: Input, dependencias: Dependencias) {
        self.input = input
        self.dependencias = dependencias
        self.router = dependencias.router
        self.useCases = dependencias.useCases
        self.output = Presenter.output(input:self.input, useCases: self.useCases)
        self.process()
    }
}

private extension Presenter {
    
    static func output(input: Input, useCases: UseCases) -> Output {
       
       let chatrooms = useCases.output.chatrooms
            .map(ChatroomViewModel.build(models:))
            .map(ChatroomsSection.sections(usingItems:))
            .asDriver(onErrorJustReturn: [])
            
           
        return (
            sections: chatrooms, ()
        )
    }
    
    func process() {
        self.useCases.input
            .fetchChatrooms()
            .debug("FetchChatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
    }
}

struct ChatroomsSection {
    var hearder: Int
    var items: [Item]
}

extension ChatroomsSection: AnimatableSectionModelType {

    typealias Item = ChatroomViewModel
    typealias Identity = Int
    
    var identity: Int {
        return hearder
    }
    
    init(original: ChatroomsSection, items: [Item]) {
        self = original
        self.items = items
        
    }
}

extension ChatroomsSection {
    
    init(items: [Item]) {
        self.init(hearder: 0, items: items)
    }
    
    static func sections(usingItems items: [Item]) -> [ChatroomsSection] {
        return [ChatroomsSection(items: items)]
    }
}

struct ChatroomViewModel {
    let id: String
    let title: String
    let timestamp: BehaviorRelay<String> = BehaviorRelay(value: "")
    let statusMessage:  BehaviorRelay<String> = BehaviorRelay(value: "")
    let unreadCout:  BehaviorRelay<Int> = BehaviorRelay(value: 0)
}

extension ChatroomViewModel {
    
    init(usingModel model: Chatroom) {
        self.id = model.id
        self.title = model.name
        self.statusMessage.accept(model.subject)
        self.timestamp.accept(model.createdAt.converToDate()?.timeAgoSinceNow() ?? "Unknown")
    }
    
    static func build(models: Set<Chatroom>) -> [ChatroomViewModel] {
        return models.compactMap({ ChatroomViewModel(usingModel: $0)})
    }
}

extension ChatroomViewModel: IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func == (lhs: ChatroomViewModel, rhs: ChatroomViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}


