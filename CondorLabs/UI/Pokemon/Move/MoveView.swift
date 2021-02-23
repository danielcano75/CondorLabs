//
//  MoveView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

struct MoveView: View {
    private let line: CGFloat = 2
    private let vertical: CGFloat = 5
    private let corner: CGFloat = 5
    private let padding: CGFloat = 10
    
    @ObservedObject var viewModel: MoveViewModel
    var selected: Bool
    var select: (Move) -> ()
    
    init(url: String,
         isFirst: Bool,
         selected: Bool,
         select: @escaping (Move) -> ()) {
        self.viewModel = MoveViewModel(url: url,
                                       isFirst: isFirst)
        self.selected = selected
        self.select = select
    }
    
    var body: some View {
        Button(action: {
            select(viewModel.move)
        }) {
            VStack {
                HStack(spacing: padding) {
                    Text(viewModel.move.type.name.capitalizingFirstLetter())
                        .padding(.vertical, vertical)
                        .padding(.horizontal, padding)
                        .background(viewModel.move.color())
                        .cornerRadius(corner)
                    Spacer()
                    Text(viewModel.move.name)
                    Spacer()
                    Text("PP").mediumTextFont(decoration: .regular)
                    Text("\(viewModel.move.pp)" + "/" + "\(viewModel.move.pp)")
                }
                Divider()
            }
        }
        .textFont(decoration: .regular)
        .padding(.horizontal)
        .padding(.vertical, vertical)
        .background(selected ? Color.cSection.opacity(0.5) : Color.cBackground)
        .overlay(
            RoundedRectangle(cornerRadius: selected ? corner : .zero)
                .stroke(selected ? Color.cPrimary : Color.clear,
                        lineWidth: selected ? line : .zero)
                )
        .onAppear {
            viewModel.get {
                select(viewModel.move)
            }
        }
        .disabled(viewModel.move.id == .zero ? true : false)
    }
}

struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        MoveView(url: "https://pokeapi.co/api/v2/move/13",
                 isFirst: true,
                 selected: true) { _ in
        }
    }
}
