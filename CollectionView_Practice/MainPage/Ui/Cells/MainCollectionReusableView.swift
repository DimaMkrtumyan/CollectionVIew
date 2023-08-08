//
//  MainCollectionReusableView.swift
//  CollectionView_Practice
//
//  Created by Dmitriy Mkrtumyan on 08.08.23.
//

import UIKit

final class MainCollectionReusableView: UICollectionReusableView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .cyan
        return titleLabel
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert text..."
        textField.textColor = .white
        return textField
    }()
    
    func setupTitle(for header: String) {
        titleLabel.text = header
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(textField)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 12),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.widthAnchor.constraint(equalToConstant: 38)
        ])
        
        titleLabel.textAlignment = .left
        backgroundColor = .magenta
    }

}
