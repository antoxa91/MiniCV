//
//  ProfileViewModel.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import Foundation

struct ProfileViewModel: Decodable {
    let profile: Profile
    let skills: [String]
}

struct Profile: Decodable {
    let image: Data?
    let name: String
    let bio: String
    let location: String
    let about: String
}
