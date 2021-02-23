//
//  Generation.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

struct Generation: Codable, Identifiable {
    var id: Int = .zero
    var name: String = ""
    var region: Region = .init()
    var languages: [Language] = []
    var pokemon: [Pokemon] = []
    
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
