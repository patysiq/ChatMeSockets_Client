//
//  FriendsViewController.swift
//  Friends
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import EmptyView

class FriendsViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }
    
}

private extension FriendsViewController {
    
    func setupUI() {
        guard let emptyImage = UIImage(systemName: "figure.socialdance") else {return}
        let emptyView = EmptyView(frame: .zero)
        emptyView.config(image: emptyImage, title: "Aaaaaa!", subtitle: "Nenhum amigo apareceu ainda.")
        tableview.backgroundView = emptyView
    }
    
    func setupBinding() {
        
    }
}
