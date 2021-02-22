//
//  Generation.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

struct Generation: Codable, Identifiable {
    let id: Int
    let name: String
    let region: Region
    let languages: [Language]
    let pokemon: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case region = "main_region"
        case languages = "names"
        case pokemon = "pokemon_species"
    }
}

extension Generation {
    func Name() -> String {
        let language = languages.first {
            $0.language.name == (Locale.current.languageCode ?? "en")
        }
        return language?.name ?? ""
    }
}
