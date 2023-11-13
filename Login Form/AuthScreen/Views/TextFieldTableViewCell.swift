//
//  TableViewCell.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 06.11.2023.
//

import Foundation
import UIKit

protocol TextFieldTableViewCellDelegate: AnyObject {
    func textDidChange(tag: Int, text: String?)
}

struct TextFieldTableViewCellViewModel {
    let placeholder: String
    let text: String?
}

class TextFieldTableViewCell: UITableViewCell {
    
    static let identifier = "TextFieldTableViewCell"
    weak var delegate: TextFieldTableViewCellDelegate?
    
    //    MARK: - UI
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with viewModel: TextFieldTableViewCellViewModel) {
        textField.placeholder = viewModel.placeholder
        textField.text = viewModel.text
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textDidChange(tag: tag, text: textField.text)
    }
}

private extension TextFieldTableViewCell {
    func commonInit() {
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
