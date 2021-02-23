//
//  Color.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI
import UIKit

extension Color {
    static let cPrimary = Color("Primary")
    static let cSecondary = Color("Secondary")
    static let cBackground = Color("Background")
    static let cText = Color("Text")
    static let cSection = Color("Section")
    static func type(_ type: TypePokemon) -> Color {
        return Color(type.rawValue)
    }
}

extension UIColor {
    static let cPrimary = UIColor(named: "Primary")
    static let cSecondary = UIColor(named: "Secondary")
    static let cBackground = UIColor(named: "Background")
    static let cText = UIColor(named: "Text")
    static let cSection = UIColor(named: "Section")
    static func type(_ type: TypePokemon) -> UIColor {
        return UIColor(named: type.rawValue) ?? .gray
    }
}

