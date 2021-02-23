//
//  Font.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI

enum DecorationType: String {
    case bold       = "Roboto-Bold"
    case italic     = "Roboto-Italic"
    case boldItalic = "Roboto-BoldItalic"
    case light      = "Roboto-Light"
    case medium     = "Roboto-Medium"
    case regular    = "Roboto-Regular"
    case futura     = "Futura-Medium"
    case hollow     = "Pokemon Hollow"
    case solid      = "Pokemon Solid"
}

enum FontSizeType: CGFloat {
    case large      = 48.0
    case bigTitle   = 25.0
    case navTitle   = 24.0
    case title      = 20.0
    case text       = 16.0
    case mediumText = 14.0
    case smallText  = 12.0
    case small      = 10.0
}
struct BigTitleFont: ViewModifier {
    
    var color: Color = Color.cText
    var decoration: DecorationType = .regular
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(name: decoration.rawValue,
                  size: FontSizeType.bigTitle.rawValue)
    }
}

struct TitleFont: ViewModifier {
    
    var color : Color
    var decoration: DecorationType
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(name: decoration.rawValue,
                  size: FontSizeType.title.rawValue)
    }
}

struct TextFont: ViewModifier {
    
    var color: Color = Color.cText
    var decoration: DecorationType = .regular
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(name: decoration.rawValue,
                  size: FontSizeType.text.rawValue)
    }
}

struct MediumTextFont: ViewModifier {
    
    var color: Color = Color.cText
    var decoration: DecorationType = .regular
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(name: decoration.rawValue,
                  size: FontSizeType.mediumText.rawValue)
    }
}

struct SmallTextFont: ViewModifier {
    
    var color: Color = Color.cText
    var decoration: DecorationType = .regular
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(name: decoration.rawValue,
                  size: FontSizeType.smallText.rawValue)
    }
}

struct TextFontSize: ViewModifier {
    
    var size: CGFloat = FontSizeType.text.rawValue
    var color: Color = Color.cText
    var decoration: DecorationType = .regular
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(name: decoration.rawValue,
                  size: size)
    }
}

struct FontUtility: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension View {
    func font(name: String, size: CGFloat) -> some View {
        return self.modifier(FontUtility(name: name, size: size))
    }
}

extension View {
    func bigTitleFont(color: Color = Color.cText,
                      decoration: DecorationType = .regular) -> some View {
        self.modifier( BigTitleFont(color: color, decoration: decoration) )
    }
    
    func titleFont(color: Color = Color.cText,
                   decoration: DecorationType = .regular) -> some View {
        self.modifier( TitleFont(color: color, decoration: decoration) )
    }
    
    func textFont(color: Color = Color.cText,
                  decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFont(color: color, decoration: decoration) )
    }
    
    func mediumTextFont(color: Color = Color.cText,
                        decoration: DecorationType = .regular) -> some View {
        self.modifier( MediumTextFont(color: color, decoration: decoration) )
    }
    
    func smallTextFont(color: Color = Color.cText,
                       decoration: DecorationType = .regular) -> some View {
        self.modifier( SmallTextFont(color: color, decoration: decoration) )
    }
    
    func textFontSize(size: CGFloat = FontSizeType.text.rawValue ,
                      color: Color = Color.cText,
                      decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: size,color: color, decoration: decoration) )
    }
}
