//
//  AuthTableHeader.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 06.11.2023.
//

import UIKit

protocol AuthTableHeaderDelegate: AnyObject {
    func selectedIndexDidChange(currentIndex: Int)
}

struct AuthTableHeaderViewModel {
    let selectedIndex: Int
}

class AuthTableHeader: UIView {
    
    weak var delegate: AuthTableHeaderDelegate?
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Вход", "Регистрация"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeDataSourse(_:)), for: .valueChanged)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with viewModel: AuthTableHeaderViewModel) {
        segmentedControl.selectedSegmentIndex = viewModel.selectedIndex
    }
    
    @objc func changeDataSourse(_ sender: UISegmentedControl) {
        let currentIndex = sender.selectedSegmentIndex
        delegate?.selectedIndexDidChange(currentIndex: currentIndex)
    }
}

private extension AuthTableHeader {
    func commonInit() {
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
