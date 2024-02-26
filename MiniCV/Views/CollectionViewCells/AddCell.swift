//
//  AddCell.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

final class AddCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: AddCell.self)
    
    var onAddTapped: (() -> Void)?
    
    private lazy var addSkillButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.onAddTapped?()
        }, for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Private Methods
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addSkillButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            addSkillButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            addSkillButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            addSkillButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupUI() {
        contentView.addSubview(addSkillButton)
        contentView.backgroundColor = .dynamicBackgroundColor
        contentView.layer.cornerRadius = 12
    }
}
