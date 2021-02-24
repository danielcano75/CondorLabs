//
//  Region.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

struct Region: Codable {
    var name: String = ""
    var url: String = ""
}

#if DEBUG
extension Region {
    static var mock = Region(name: "kanto",
                             url: "https://pokeapi.co/api/v2/region/1/")
    static func mock(name: String = "kanto",
                     url: String = "https://pokeapi.co/api/v2/region/1/") -> Region {
        .init(name: name,
              url: url)
    }
}
#endif
