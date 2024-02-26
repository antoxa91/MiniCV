//
//  AboutView.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

final class AboutView: UIView {
    
    // MARK: Private UI Properties
    private lazy var aboutMeStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "О себе"
        return label
    }()
    
    private lazy var aboutProfileTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Private Methods
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .dynamicSkillsViewColor
        addSubviews(aboutMeStaticLabel, aboutProfileTextLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            aboutMeStaticLabel.topAnchor.constraint(equalTo: topAnchor),
            aboutMeStaticLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            aboutProfileTextLabel.topAnchor.constraint(equalTo: aboutMeStaticLabel.bottomAnchor, constant: padding/2),
            aboutProfileTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            aboutProfileTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}

// MARK: - ConfigurableViewProtocol
extension AboutView: ConfigurableViewProtocol {
    func configure(with model: Profile) {
        aboutProfileTextLabel.text = model.about
    }
}
