//
//  Cell.swift
//  TodoList
//
//  Created by Dmitry Kaveshnikov on 3/6/22.
//

import Foundation

import UIKit
import SwipeCellKit

protocol Configurable {
    associatedtype Model
    func configure(model: Model)
}

final class Cell: SwipeTableViewCell {
    // MARK: Static
    static let identifier = K.reuseCellName
    
    // MARK: Properties
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
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
        contentView.addSubview(label)
        contentView.backgroundColor = .white
        contentView.tintColor = .systemBlue
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor)
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

