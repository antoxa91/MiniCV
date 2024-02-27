//
//  ProfileLoaderService.swift
//  MiniCV
//
//  Created by Антон Стафеев on 27.02.2024.
//

import Foundation

protocol ProfileLoaderServiceProtocol {
    func loadJson(fileName: String) throws -> ProfileViewModel?
}

enum ProfileLoadingError: Error {
    case fileNotFound
    case decodingFailed(String)
    case dataUnavailable
}

final class ProfileLoaderService: ProfileLoaderServiceProtocol {
    
    func loadJson(fileName: String) throws -> ProfileViewModel? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw ProfileLoadingError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ProfileViewModel.self, from: data)
            return jsonData
        } catch {
            throw ProfileLoadingError.decodingFailed(error.localizedDescription)
        }
    }
}
