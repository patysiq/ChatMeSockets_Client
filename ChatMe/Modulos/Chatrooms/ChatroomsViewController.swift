//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import EmptyView
import Utility

class ChatroomsViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    @IBOutlet weak var tableview: UITableView!
    
    private lazy var createChatroomButton: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        button.tintColor = .deepBlue
        guard let createImage = UIImage(systemName: "square.and.pencil") else {return button}
        let yPosition = self.view.frame.height - 180
        let xPosition = self.view.frame.width - 100
        button.setImage(createImage, for: .normal)
        button.frame = CGRect(origin: CGPoint(x: xPosition, y: yPosition), size: CGSize(width: 60, height: 60))
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.layer.zPosition = 1
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }

}

private extension ChatroomsViewController {
    
    func setupUI() {
        self.view.addSubview(createChatroomButton)
        guard let emptyImage = UIImage(systemName: "stopwatch") else {return}
        let emptyView = EmptyView(frame: .zero)
        emptyView.config(image: emptyImage, title: "Uh Ho", subtitle: "Parece que não há salas de chat.")
        tableview.backgroundView = emptyView
    }
    
    func setupBinding() {
        
    }
}
