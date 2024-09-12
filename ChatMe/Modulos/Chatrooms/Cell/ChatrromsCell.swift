//
//  ChatrromsCell.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 12/09/24.
//

import UIKit
import RxSwift
import RxCocoa

class ChatroomsCell: UITableViewCell {
    
    @IBOutlet weak var chatroomImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var unreadCountLabel: UILabel!
    
    private(set) var reuseBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(usingViewModel viewModel: ChatroomViewModel) {
        self.titleLabel.text = viewModel.title
        self.chatroomImageView.image = UIImage(systemName: "person")
        viewModel.statusMessage
            .asDriver()
            .drive(self.statusLabel.rx.text)
            .disposed(by: reuseBag)
        viewModel.timestamp
            .asDriver()
            .drive(self.timestampLabel.rx.text)
            .disposed(by: reuseBag)
        
    }
    
}
