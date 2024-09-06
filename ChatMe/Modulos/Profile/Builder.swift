//
//  Builder.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import Utility

public final class Builder {
    
    public static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: Bundle(for: self))
        let view = ProfileViewController.instatiate(from: storyboard)
        view.title = "Profile"
        
        let submodules: Router.Submodules = ()
        let router = Router(viewController: view, submodules: submodules)
        
        view.presenterProducer = { input in
            Presenter(input: input, dependencias: (
                router: router,
                useCases: (
                    input: (),
                    output: ()
                )
            ))
        }
        
        return factory(view)
    }
    
}
