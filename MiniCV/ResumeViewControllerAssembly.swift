//
//  ResumeViewControllerAssembly.swift
//  MiniCV
//
//  Created by Антон Стафеев on 27.02.2024.
//

import UIKit

struct ResumeViewControllerAssembly {
    
    func create() throws -> UIViewController {
        let profileLoaderService: ProfileLoaderServiceProtocol = ProfileLoaderService()
        guard let profileViewModel = try profileLoaderService.loadJson(fileName: "MiniCV") else {
            throw ProfileLoadingError.dataUnavailable
        }
        
        let controller = UINavigationController(rootViewController: MiniCVViewController(profileViewModel, profileLoaderService))
        
        return controller
    }
}
