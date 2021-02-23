//
//  PokemonView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonView: View {
    private let line: CGFloat = 2
    private let vertical: CGFloat = 5
    private let corner: CGFloat = 5
    private let padding: CGFloat = 10
    private let size: CGFloat = 55
    
    var type: GenerationType
    var pokemon: Pokemon
    var detail: () -> ()
    
    var body: some View {
        Button(action: {
            detail()
        }) {
            VStack {
                HStack {
                    WebImage(url: pokemon.artwork(type: type))
                        .onSuccess { image, cache in
                        }
                        .renderingMode(.original)
                        .resizable()
                        .placeholder(Image("Pokeball"))
                        .indicator(.activity)
                        .transition(.fade)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size,
                               height: size)
                        .padding(padding)
                        .background(Color.cSection)
                        .overlay(
                            RoundedRectangle(cornerRadius: corner)
                                .stroke(Color.gray,
                                        lineWidth: line)
                                )
                    Text("Pokémon: ").titleFont(decoration: .bold)
                    Text(pokemon.name.capitalizingFirstLetter())
                    Spacer()
                }
                Divider()
            }
        }
        .titleFont(decoration: .regular)
        .padding(.horizontal)
        .padding(.top, vertical)
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(type: .i,
                    pokemon: .init(name: "bulbasaur",
                                   url: "https://pokeapi.co/api/v2/pokemon-species/1/")) {
        }
    }
}
