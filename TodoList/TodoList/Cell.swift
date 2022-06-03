//
//  Cell.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 3/6/22.
//

import Foundation

import UIKit

protocol Configurable {
    associatedtype Model
    
    func configure(model: Model)
}

final class Cell: UITableViewCell {
    // MARK: Static
    static let identifier = K.reuseCellName
    
    // MARK: Properties
    private let label = UILabel()
    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup
    private func setupView() {
        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(label)
        contentView.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Configurable
extension Cell: Configurable {
    struct Model {
        let text: String
    }
    
    func configure(model: Model) {
        label.text = model.text
    }
}

