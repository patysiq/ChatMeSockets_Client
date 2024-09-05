//
//  Window.swift
//  Window
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit

protocol Presentation {
    
}

class Window: UIWindow {
    
    var presenter: Presentation?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
