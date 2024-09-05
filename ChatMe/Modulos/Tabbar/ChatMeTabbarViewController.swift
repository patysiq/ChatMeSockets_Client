//
//  ChatMeTabbarViewController.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

typealias ChaMeTabs = ()

protocol Presentation {
    
}

protocol TabbarView: AnyObject {
    
}

class ChatMeTabbarViewController: UITabBarController {
    
    var presenter: Presentation?
    
    init(tabs: ChaMeTabs) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension ChatMeTabbarViewController : TabbarView {
    
}
