//
//  MiniCVViewController.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

final class MiniCVViewController: UIViewController {
    
    // MARK: Private Properties
    private var profileViewModel: ProfileViewModel
    private let profileLoaderService: ProfileLoaderServiceProtocol
    
    private lazy var infoView = InfoView()
    private lazy var aboutView = AboutView()
    private lazy var skillsView = SkillsView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.contentInsetAdjustmentBehavior = .always
        return scrollView
    }()
    
    // MARK: Init
    init(_ profileViewModel: ProfileViewModel, _ profileLoaderService: ProfileLoaderServiceProtocol) {
        self.profileViewModel = profileViewModel
        self.profileLoaderService = profileLoaderService
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setConstraints()
        configureSubviews()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .dynamicBackgroundColor
        title = "Профиль"
        navigationController?.navigationBar.barTintColor = .dynamicBackgroundColor
        view.addSubview(scrollView)
        scrollView.addSubviews(infoView, skillsView, aboutView)
        skillsView.delegate = self
    }
    
    private func configureSubviews() {
        infoView.configure(with: profileViewModel.profile)
        aboutView.configure(with: profileViewModel.profile)
        skillsView.configure(with: profileViewModel)
    }
}


// MARK: - SkillsViewDelegate
extension MiniCVViewController: SkillsViewDelegate {
    func didTapAddSkill() {
        let ac = UIAlertController(title: "Добавить новый навык", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "Добавить", style: .default) { [weak self, weak ac] _ in
            guard let skill = ac?.textFields?.first?.text,
                  !skill.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            let newIndex = self?.skillsView.getAllSkills().count ?? 0
            self?.skillsView.addSkill(skill, index: newIndex)
        })
        
        present(ac, animated: true)
    }
    
    func didTapCloseSkill(at indexPath: IndexPath) {
        guard indexPath.item >= 0 && indexPath.item < skillsView.getAllSkills().count else {
            return
        }
        skillsView.deleteSkill(indexPath.item)
    }
}

// MARK: - Layout
private extension MiniCVViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            infoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            infoView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            infoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            infoView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.65),
            
            skillsView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 20),
            skillsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            skillsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            aboutView.topAnchor.constraint(equalTo: skillsView.bottomAnchor),
            aboutView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            aboutView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            aboutView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            aboutView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250)
        ])
    }
}
