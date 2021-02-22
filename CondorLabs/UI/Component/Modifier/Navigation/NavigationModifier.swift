//
//  NavigationModifier.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI

// MARK: This modifier customizing the navigation bar
struct NavigationModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    var textColor: UIColor?
    var size: CGFloat
    
    init(backgroundColor: UIColor?,
         textColor: UIColor?,
         size: CGFloat) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.size = size
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: textColor ?? .clear,
                                                 .font: UIFont(name: DecorationType.bold.rawValue,
                                                               size: self.size) as Any]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor ??  .clear,
                                                      .font: UIFont(name: DecorationType.bold.rawValue,
                                                                    size: self.size) as Any]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = textColor
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?,
                            textColor: UIColor? = UIColor.cPrimary,
                            title size: CGFloat = FontSizeType.navTitle.rawValue) -> some View {
        self.modifier(NavigationModifier(backgroundColor: backgroundColor,
                                         textColor: textColor,
                                         size: size))
    }
}
