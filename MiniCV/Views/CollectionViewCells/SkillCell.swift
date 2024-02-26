//
//  SkillCell.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

protocol ConfigureSkillCellProtocol: AnyObject {
    func configure(model: String, isEditMode: Bool, maxWidth: CGFloat, indexPath: IndexPath)
}

final class SkillCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: SkillCell.self)
    
    // MARK: Private Properties
    private lazy var skillTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var removeSkillButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .label
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.addAction(UIAction { [weak self] _ in
            self?.didTapRemove()
        }, for: .touchUpInside)
        return btn
    }()
    
    var onCloseTapped: (() -> Void)?
    private var indexPath: IndexPath?
    
    private var textTrailing: NSLayoutConstraint?
    private var textClosedButtonTrailing: NSLayoutConstraint?
    private var cellWidth: NSLayoutConstraint?
    
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
    private func setupUI() {
        contentView.addSubviews(skillTextLabel, removeSkillButton)
        contentView.backgroundColor = .dynamicBackgroundColor
        contentView.layer.cornerRadius = 12
    }
    
    private func didTapRemove() {
        onCloseTapped?()
        removeSkillButton.tintColor = .systemRed
        skillTextLabel.textColor = .systemRed
    }
}

// MARK: - Layout
private extension SkillCell {
    func setConstraints() {
        textTrailing = skillTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        textTrailing?.isActive = true
        
        textClosedButtonTrailing = skillTextLabel.trailingAnchor.constraint(equalTo: removeSkillButton.leadingAnchor, constant: -10)
        
        cellWidth = contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        cellWidth?.isActive = true
        
        NSLayoutConstraint.activate([
            skillTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            skillTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            removeSkillButton.widthAnchor.constraint(equalToConstant: 16),
            removeSkillButton.heightAnchor.constraint(equalToConstant: 16),
            removeSkillButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            removeSkillButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}

// MARK: - ConfigureSkillCellProtocol
extension SkillCell: ConfigureSkillCellProtocol {
    func configure(model: String, isEditMode: Bool, maxWidth: CGFloat, indexPath: IndexPath) {
        contentView.layoutIfNeeded()
        
        skillTextLabel.text = model
        skillTextLabel.textColor = .label
        skillTextLabel.invalidateIntrinsicContentSize()
        
        removeSkillButton.isHidden = !isEditMode
        removeSkillButton.tintColor = .label
        
        textTrailing?.isActive = !isEditMode
        textClosedButtonTrailing?.isActive = isEditMode
        
        cellWidth?.constant = maxWidth
        self.indexPath = indexPath
    }
}
