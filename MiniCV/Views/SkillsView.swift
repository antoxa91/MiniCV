//
//  SkillsView.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

protocol SkillsViewDelegate: AnyObject {
    func didTapAddSkill()
    func didTapCloseSkill(at indexPath: IndexPath)
}

protocol SkillsViewProtocol: AnyObject {
    func deleteSkill(_ index: Int)
    func addSkill(_ skill: String, index: Int)
    func getAllSkills() -> [String]
}

final class SkillsView: UIView {
    weak var delegate: SkillsViewDelegate?
    
    private var skills: [String] = []
    private var isEditMode = false

    // MARK: Private UI Properties
    private lazy var mySkillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = String(localized: "My Skills")
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addAction(UIAction { [weak self] _ in
            self?.editButtonTapped()
        }, for: .touchUpInside)
        btn.setImage(UIImage(resource: .pencil), for: .normal)
        btn.tintColor = .label
        return btn
    }()
        
    private lazy var skillsCollectionView: UICollectionView = {
        let alignedFlowLayout = LeftAlignedCollectionViewFlowLayout()
        alignedFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .dynamicSkillsViewColor
        cv.register(SkillCell.self, forCellWithReuseIdentifier: SkillCell.reuseIdentifier)
        cv.register(AddCell.self, forCellWithReuseIdentifier: AddCell.reuseIdentifier)
        return cv
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .dynamicSkillsViewColor
        addSubviews(mySkillsLabel, editButton, skillsCollectionView)
        skillsCollectionView.dataSource = self
    }
    
    // MARK: Private Methods
    private func editButtonTapped() {
        isEditMode.toggle()
        skillsCollectionView.reloadData()
        
        let btnImage = isEditMode ? UIImage(systemName: "checkmark.circle") : UIImage(resource: .pencil)
        UIView.transition(with: editButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.editButton.setImage(btnImage, for: .normal)
        })
    }
    
    private func getAddCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let addCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCell.reuseIdentifier,
            for: indexPath
        ) as? AddCell else { return UICollectionViewCell() }
        
        addCell.onAddTapped = { [weak self] in
            self?.delegate?.didTapAddSkill()
        }
        
        return addCell
    }
    
    private func getSkillCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let skillCell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillCell.reuseIdentifier, for: indexPath) as? SkillCell else {
            return UICollectionViewCell()
        }
        
        let skill = skills[indexPath.item]
        
        skillCell.configure(model: skill, isEditMode: isEditMode, maxWidth: frame.width - 40, indexPath: indexPath)
        
        skillCell.onCloseTapped = { [weak self] in
            self?.delegate?.didTapCloseSkill(at: indexPath)
        }
                
        return skillCell
    }
}


// MARK: - UICollectionViewDataSource
extension SkillsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isEditMode ? skills.count + 1 : skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEditMode && indexPath.item == skills.count {
            return getAddCell(collectionView, at: indexPath)
        } else {
            return getSkillCell(collectionView, at: indexPath)
        }
    }
}

// MARK: - SkillsViewProtocol
extension SkillsView: SkillsViewProtocol {
    func addSkill(_ skill: String, index: Int) {
        skills.append(skill)

        skillsCollectionView.performBatchUpdates ({
            skillsCollectionView.insertItems(at: [IndexPath(item: index, section: 0)])
        }, completion: { [weak self] _ in
            self?.skillsCollectionView.reloadData()
        })
    }
    
    func deleteSkill(_ index: Int) {
        guard index >= 0 && index < skills.count else {
            return
        }
        
        skills.remove(at: index)
        
        skillsCollectionView.performBatchUpdates ({
            skillsCollectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }, completion: { [weak self] _ in
            self?.skillsCollectionView.reloadData()
        })
    }
    
    func getAllSkills() -> [String] {
        return skills
    }
}

// MARK: - Layout
private extension SkillsView {
     func setConstraints() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            
            mySkillsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mySkillsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mySkillsLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),
            
            skillsCollectionView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 16),
            skillsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            skillsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            skillsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
}

// MARK: - ConfigurableViewProtocol
extension SkillsView: ConfigurableViewProtocol {
    func configure(with model: ProfileViewModel) {
        self.skills = model.skills
    }
}
