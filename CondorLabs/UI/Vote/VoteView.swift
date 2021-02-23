//
//  VoteView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

struct VoteView: View {
    private let top: CGFloat = 88
    private let size: CGFloat = 500
    @ObservedObject var viewModel: VoteViewModel
    @Binding var vote: Bool
    
    init(vote: Binding<Bool>,
         type: GenerationType,
         pokemons: [Pokemon]) {
        self.viewModel = VoteViewModel(type: type,
                                       pokemon: pokemons)
        _vote = vote
    }
    
    private func getWidth(_ geometry: GeometryProxy,
                          id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(viewModel.pokemon.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    private func getOffset(_ geometry: GeometryProxy,
                           id: Int) -> CGFloat {
        return  CGFloat(viewModel.pokemon.count - 1 - id) * 10
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.cText]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                VStack {
                    ZStack {
                        ForEach(.zero..<(viewModel.pokemon.count), id: \.self) { index in
                            PokeCardView(type: viewModel.type,
                                         id: viewModel.pokemon[index].id()) { status, pokemon in
                                viewModel.pokemon.removeAll {
                                    $0.id() == pokemon.id
                                }
                                if viewModel.pokemon.isEmpty {
                                    vote = false
                                }
                            }
                            .animation(.spring())
                            .frame(width: getWidth(geometry, id: index),
                                   height: size)
                            .offset(x: .zero,
                                    y: getOffset(geometry, id: index))
                        }
                    }
                }
            }
        }
        .padding(.top, UIDevice.current.notchSize + top)
        .padding(.horizontal)
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView(vote: .constant(true),
                 type: .i,
                 pokemons: [.init()])
    }
}
