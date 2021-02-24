//
//  EmptyStateView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 24/02/21.
//

import SwiftUI

struct EmptyStateView: View {
    private let spacing: CGFloat = 35
    private let padding: CGFloat = 60
    
    var title: String
    
    var body: some View {
        VStack(spacing: spacing) {
            Image("Empty")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
            Text(title)
                .multilineTextAlignment(.center)
        }
        .padding(padding)
        .titleFont(decoration: .bold)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(title: "No pokemon found, please try again later")
    }
}
