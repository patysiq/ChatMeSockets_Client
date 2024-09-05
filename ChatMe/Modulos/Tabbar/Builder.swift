//
//  Builder.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit


public final class Builder {
    
    public static func build() -> UITabBarController {
        let submodules: Router.Submodules = ()
        let tabs: ChaMeTabs = Router.tabs(usingSubmodules: submodules)
        let presenter = Presenter(useCases: ())
        let view = ChatMeTabbarViewController(tabs: tabs)
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
}
