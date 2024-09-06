//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import EmptyView

class ChatroomsViewController: UIViewController {
    
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

private extension ChatroomsViewController {
    
    func setupUI() {
        guard let emptyImage = UIImage(systemName: "stopwatch") else {return}
        let emptyView = EmptyView(frame: .zero)
        emptyView.config(image: emptyImage, title: "Uh Ho", subtitle: "Parece que não há salas de chat.")
        tableview.backgroundView = emptyView
    }
    
    func setupBinding() {
        
    }
}
