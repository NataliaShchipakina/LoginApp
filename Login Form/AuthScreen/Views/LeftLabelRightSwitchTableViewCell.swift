//
//  LeftLabelRightSwitchTableViewCell.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 06.11.2023.
//

import UIKit

protocol LeftLabelRightSwitchTableViewCellDelegate: AnyObject {
    func switchDidChange(tag: Int, isOn: Bool)
}

struct LeftLabelRightSwitchTableViewCellViewModel {
    let text: String
    let isOnAgreementSwitch: Bool
}

class LeftLabelRightSwitchTableViewCell: UITableViewCell {

    static let identifier = "LeftLabelRightSwitchTableViewCell"
    weak var delegate: LeftLabelRightSwitchTableViewCellDelegate?

    private let agreementLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var agreementSwitch: UISwitch = {
        let agreeSwitch = UISwitch()
        agreeSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        return agreeSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with viewModel: LeftLabelRightSwitchTableViewCellViewModel) {
        agreementLabel.text = viewModel.text
        agreementSwitch.setOn(viewModel.isOnAgreementSwitch, animated: false)
    }
    
    @objc private func switchDidChange(_ agreementSwitch: UISwitch) {
        delegate?.switchDidChange(tag: tag, isOn: agreementSwitch.isOn)
    }
}

private extension LeftLabelRightSwitchTableViewCell {
   func commonInit() {
       contentView.addSubview(agreementLabel)
       contentView.addSubview(agreementSwitch)
       
       agreementLabel.translatesAutoresizingMaskIntoConstraints = false
       agreementSwitch.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
        agreementLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        agreementLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        agreementLabel.trailingAnchor.constraint(lessThanOrEqualTo: agreementSwitch.leadingAnchor, constant: -8),
        agreementLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        
        agreementSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        agreementSwitch.leadingAnchor.constraint(greaterThanOrEqualTo: agreementLabel.trailingAnchor, constant: 8),
        agreementSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        agreementSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
       ])
    }
}

