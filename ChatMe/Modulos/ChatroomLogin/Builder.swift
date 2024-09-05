//
//  Builder.swift
//  ChatroomLogin
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(onLogin: @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "ChatroomLogin", bundle: Bundle(for: self))
        let view = ChatroomLoginViewController.instatiate(from: storyboard)
        
        let accountInteractor = UseCasesFactory.accountsInteractor
        let router = Router(viewController: view, onLogin: onLogin)
        
        view.presenterProducer = {
            Presenter.init(
                input: $0,
                router: router,
                useCases: (
                    login: accountInteractor.login, ()
                )
            )
        }
        
        return view
    }
}
