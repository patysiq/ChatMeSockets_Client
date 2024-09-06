//
//  FriendsViewController.swift
//  Friends
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }
    
}

private extension FriendsViewController {
    
    func setupUI() {
        
    }
    
    func setupBinding() {
        
    }
}
