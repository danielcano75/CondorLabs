//
//  GenerationView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI

struct GenerationView: View {
    @ObservedObject var viewModel = GenerationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    ForEach(viewModel.generations) { generation in
                        Section(header: HeaderView(title: generation.Name())) {
                            ForEach(.zero..<generation.pokemon.count) { index in
                                PokemonView(pokemon: generation.pokemon[index])
                            }
                        }
                    }
                }.onAppear {
                    viewModel.get {
                        
                    }
                }
            }
            .navigationBarTitle(Text("Pokemon"),
                                displayMode: .automatic)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor.cBackground
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.cSecondary ?? .white]
            })
        }
    }
}

struct HeaderView: View {
    private let padding: CGFloat = 5
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.horizontal)
                .padding(.vertical, padding)
            Spacer()
        }.background(Color.cSection)
    }
}

struct GenerationView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationView()
    }
}
