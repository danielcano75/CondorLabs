//
//  Language.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

struct Language: Codable {
    let language: LanguageName
    let name: String
}

struct LanguageName: Codable {
    let name: String
    let url: String
}

#if DEBUG
extension Language {
    static var mock = Language(language: .mock,
                               name: "Generation I")
    static func mock(language: LanguageName = .mock(),
                     name: String = "Generation I") -> Language {
        .init(language: language,
              name: name)
    }
}

extension LanguageName {
    static var mock = LanguageName(name: "en",
                                   url: "https://pokeapi.co/api/v2/language/9/")
    static func mock(name: String = "en",
                     url: String = "https://pokeapi.co/api/v2/language/9/") -> LanguageName {
        .init(name: name,
              url: url)
    }
}
#endif
