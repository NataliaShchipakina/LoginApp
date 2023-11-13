//
//  ButtonTableViewCell.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 06.11.2023.
//

import UIKit

protocol ButtonTableViewCellViewModelDelegate: AnyObject {
    func buttonDidTap(tag: Int)
}

struct ButtonTableViewCellViewModel {
    let buttonText: String
}

class ButtonTableViewCell: UITableViewCell {

    static let identifier = "ButtonTableViewCell"
    weak var delegate: ButtonTableViewCellViewModelDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with viewModel: ButtonTableViewCellViewModel) {
        button.setTitle(viewModel.buttonText, for: .normal)
    }
    
    @objc private func didTapButton(_ button: UIButton) {
        delegate?.buttonDidTap(tag: tag)
    }
}

private extension ButtonTableViewCell {
   func commonInit() {
       contentView.addSubview(button)
       
       button.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: contentView.topAnchor),
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
       ])
    }
}
