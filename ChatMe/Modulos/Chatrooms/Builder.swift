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
        
        let storyboard = UIStoryboard(name: "Chatrooms", bundle: Bundle(for: self))
        let view = ChatroomsViewController.instatiate(from: storyboard)
        view.title = "Rooms"
        
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
