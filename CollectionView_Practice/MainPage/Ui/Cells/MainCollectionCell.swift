//
//  MainCollectionCell.swift
//  CollectionView_Practice
//
//  Created by Dmitriy Mkrtumyan on 07.08.23.
//

import UIKit

final class MainCollectionCell: UICollectionViewCell {
    
    private var mainImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.contentMode = .scaleToFill
        contentView.backgroundColor = .white
        contentView.addSubview(mainImageView)
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupCell(with image: UIImage) {
        mainImageView.image = image
    }
  
}
