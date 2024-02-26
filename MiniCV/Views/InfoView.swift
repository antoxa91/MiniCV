//
//  InfoView.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

protocol ConfigurableViewProtocol {
    associatedtype ConfigirationModel
    func configure(with model: ConfigirationModel)
}

final class InfoView: UIView {
    
    // MARK: Private UI Properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .dynamicBackgroundColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(resource: .locationMark)
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.addArrangedSubview(locationImageView)
        stackView.addArrangedSubview(locationLabel)
        return stackView
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
    
    private func setupView() {
        backgroundColor = .dynamicBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(profileImageView, nameLabel, bioLabel, locationStackView)
    }
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.44),
            profileImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.44),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            locationStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 2),
            locationStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationStackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor)
        ])
    }
}

// MARK: - ConfigurableViewProtocol
extension InfoView: ConfigurableViewProtocol {
    func configure(with model: Profile) {
        nameLabel.text = model.name
        bioLabel.text = model.bio
        locationLabel.text = model.location
        
        if let data = model.image {
            profileImageView.image = UIImage(data: data)
        } else {
            profileImageView.image = UIImage(resource: .profile)
        }
    }
}
