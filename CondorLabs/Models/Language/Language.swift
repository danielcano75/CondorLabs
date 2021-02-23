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
