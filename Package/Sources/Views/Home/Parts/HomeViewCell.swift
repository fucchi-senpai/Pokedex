//
//  HomeViewCell.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/13.
//

import UIKit

// MARK: - UICollectionViewCell
class HomeViewCell: UICollectionViewCell {
    
    // MARK: Field Property
    
    private(set) static var cellIdentifier = "HomeViewCell"
    
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView(frame: .zero)
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        // TODO: move to ViewModel
        label.text = "Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        // TODO: move to ViewModel
        imageView.image = UIImage(systemName: "questionmark.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            hStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
        
        hStack.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: hStack.leftAnchor),
            imageView.centerYAnchor.constraint(equalTo: hStack.centerYAnchor)
        ])
        
        hStack.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: hStack.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
