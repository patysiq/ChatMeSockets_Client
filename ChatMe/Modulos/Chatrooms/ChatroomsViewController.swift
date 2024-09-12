//
//  ChatroomsViewController.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import EmptyView
import Utility
import RxSwift
import RxCocoa
import RxDataSources

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
    
    private var emptyView: EmptyView = {
        let emptyView = EmptyView(frame: .zero)
        let emptyImage = UIImage(systemName: "stopwatch")!
        emptyView.config(image: emptyImage, title: "Uh Ho", subtitle: "Parece que não há salas de chat.")
        return emptyView
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ChatroomsSection>(configureCell: { [weak self] (_ , tableView, indexPath, item) in
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatroomsCell.self), for: indexPath) as? ChatroomsCell else { return UITableViewCell() }
        cell.configure(usingViewModel: item)
        
        return cell
    })
    
    private var bag = DisposeBag()
    
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
        let chatroomCellNib = UINib(nibName: "ChatrromsCell", bundle: Bundle(for: type(of: self)))
        tableview.register(chatroomCellNib, forCellReuseIdentifier: String(describing: ChatroomsCell.self))
    }
    
    func setupBinding() {
        self.presenter.output.sections
            .drive(self.tableview.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        self.presenter.output.sections
            .map({ $0.first! })
            .map({ $0.items.count  > 0 })
            .map({[tableview] in tableview?.backgroundView = $0 ? nil : self.emptyView })
            .drive()
            .disposed(by: bag)
    }
}
