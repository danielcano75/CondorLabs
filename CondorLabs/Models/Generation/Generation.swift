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

#if DEBUG
extension Generation {
    static var mock = Generation(id: 1,
                                 name: "generation-i",
                                 region: .mock,
                                 languages: [.mock],
                                 pokemon: [.mock])
    static func mock(id: Int = 1,
                     name: String = "generation-i",
                     region: Region = .mock(),
                     languages: [Language] = [.mock()],
                     pokemon: [Pokemon] = [.mock()]) -> Generation {
        .init(id: id,
              name: name,
              region: region,
              languages: languages,
              pokemon: pokemon)
    }
}
#endif
