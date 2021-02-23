//
//  PokemonDetailView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailView: View {
    private let vertical: CGFloat = 5
    private let padding: CGFloat = 10
    private let hegiht = UIScreen.main.bounds.width * 0.6

    @ObservedObject var viewModel: PokemonDetailViewModel
    @State var selected: Move = .init()
    
    init(type: GenerationType,
         id: Int) {
        viewModel = PokemonDetailViewModel(type: type,
                                           id: id)
    }
    
    var body: some View {
        ZStack {
            Color.cBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: padding) {
                    Picker(selection: $viewModel.segment,
                           label: Text("Segements"),
                           content: {
                            ForEach(viewModel.segments) { segement in
                                Text(segement.name)
                                    .tag(segement)
                            }
                    })
                    .padding(.horizontal)
                    .padding(.vertical, padding)
                    .pickerStyle(SegmentedPickerStyle())
                    switch $viewModel.segment.type.wrappedValue {
                    case .info:
                        PokemonInfoView(viewModel: viewModel)
                    case .moves:
                        PokemonMovesView(viewModel: viewModel,
                                         selected: $selected)
                    }
                    Spacer()
                }
                .padding(.top)
            }
            .offset(y: hegiht)
            .padding(.bottom, hegiht)
            HeaderPokemon(viewModel: viewModel)
        }
        .onAppear {
            viewModel.get()
        }
        .titleFont(decoration: .regular)
        .navigationBarTitle(viewModel.pokemon.name.capitalizingFirstLetter(),
                            displayMode: .inline)
    }
}

struct HeaderPokemon: View {
    private let vertical: CGFloat = 5
    private let corner: CGFloat = 5
    private let padding: CGFloat = 10
    private let width = UIScreen.main.bounds.width
    private let hegiht = UIScreen.main.bounds.width * 0.6
    
    @ObservedObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        VStack {
            VStack {
                WebImage(url: URL(string: viewModel.pokemon.sprites.other.artwork.artwork))
                    .onSuccess { image, cache in
                    }
                    .renderingMode(.original)
                    .resizable()
                    .placeholder(Image("Pokeball"))
                    .indicator(.activity)
                    .transition(.fade)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width,
                           height: hegiht)
                Divider().padding(.horizontal)
            }.background(Color.cBackground)
            Spacer()
        }
        VStack {
            HStack {
                HStack(spacing: padding) {
                    Text("No.")
                    Text("\(viewModel.pokemon.pokedexId)")
                }
                .titleFont(decoration: .bold)
                .padding(.horizontal)
                .padding(.vertical, vertical)
                Spacer()
            }
            Spacer()
        }
        VStack {
            HStack {
                Text(viewModel.pokemon.name.capitalizingFirstLetter())
                    .titleFont(decoration: .bold)
                    .padding(.horizontal)
                    .padding(.vertical, vertical)
                Spacer()
            }
            Spacer()
        }
        .offset(y: hegiht - (FontSizeType.title.rawValue + padding))
        VStack {
            HStack {
                Spacer()
                ForEach(viewModel.pokemon.types) { type in
                    Text(type.type.name.capitalizingFirstLetter())
                        .titleFont(decoration: .bold)
                        .padding(.vertical, vertical)
                        .padding(.horizontal, padding)
                        .background(type.color())
                        .cornerRadius(corner)
                }
            }.padding(.trailing, padding)
            Spacer()
        }
        .offset(y: hegiht - (FontSizeType.title.rawValue + padding))
    }
}

struct PokemonInfoView: View {
    private let vertical: CGFloat = 5
    private let padding: CGFloat = 10
    
    @ObservedObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        HStack(spacing: padding) {
            Text("Weight:")
                .titleFont(decoration: .bold)
            Text("\(viewModel.pokemon.weight) pounds")
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, vertical)
        HStack(spacing: padding) {
            Text("Height:")
                .titleFont(decoration: .bold)
            Text("\(viewModel.pokemon.height) feet")
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, vertical)
        HStack(spacing: padding) {
            Text("Abilities:")
                .titleFont(decoration: .bold)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, vertical)
        LazyVStack {
            ForEach(.zero..<viewModel.pokemon.abilities.count, id: \.self) { index in
                HStack {
                    Text(viewModel.pokemon.abilities[index].ability.name.capitalizingFirstLetter())
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, vertical)
    }
}

struct PokemonMovesView: View {
    private let vertical: CGFloat = 5
    private let padding: CGFloat = 10
    
    @ObservedObject var viewModel: PokemonDetailViewModel
    @Binding var selected: Move
    
    var body: some View {
        HStack(spacing: padding) {
            Text("Moves:")
                .titleFont(decoration: .bold)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, vertical)
        LazyVStack {
            ForEach(.zero..<viewModel.pokemon.moves.suffix(5).count, id: \.self) { index in
                MoveView(url: viewModel.pokemon.moves[index].move.url,
                         isFirst: selected.name.isEmpty && index == .zero,
                         selected: selected.name.isEmpty && index == .zero ? true : selected.name == viewModel.pokemon.moves[index].move.name) { move in
                    selected = move
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, vertical)
        if !$selected.entries.wrappedValue.isEmpty {
            LazyVStack {
                ForEach(.zero..<selected.entries.count, id: \.self) { index in
                    Text(selected.entries[index].effect)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, vertical)
            .transition(.asymmetric(insertion: .move(edge: .top),
                                    removal: .move(edge: .top)))
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(type: .i,
                          id: 1)
    }
}
