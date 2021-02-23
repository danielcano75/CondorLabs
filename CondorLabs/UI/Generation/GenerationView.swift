//
//  GenerationView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI

struct GenerationView: View {
    @ObservedObject var viewModel = GenerationViewModel()
    @State var detail: Bool = false
    @State var pokemon: Pokemon = .init()
    @State var active: Int? = nil
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.red,
                                                                 .font : UIFont(name: DecorationType.solid.rawValue,
                                                                                size: FontSizeType.large.rawValue)!]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section(header: HeaderView(title: $viewModel.name,
                                                   type: $viewModel.type,
                                                   types: $viewModel.types)) {
                            ForEach(.zero..<(viewModel.generation.pokemon.count), id: \.self) { index in
                                NavigationLink(destination: PokemonDetailView(type: viewModel.type.generation,
                                                                              id: pokemon.id()),
                                               tag: viewModel.generation.pokemon[index].id(),
                                               selection: $active) {
                                    PokemonView(type: viewModel.type.generation,
                                                pokemon: viewModel.generation.pokemon[index]) {
                                        pokemon = viewModel.generation.pokemon[index]
                                        active = pokemon.id()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.get()
            }
            .navigationBarTitle(Text("Pokédex"),
                                displayMode: .automatic)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor.cBackground
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.cText ?? .white,
                                                        .font: UIFont(name: DecorationType.regular.rawValue, size: FontSizeType.title.rawValue)!]
            })
        }
    }
}

struct HeaderView: View {
    private let padding: CGFloat = 10
    
    @Binding var title: String
    @Binding var type: GenerationSegment
    @Binding var types: [GenerationSegment]
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading)
                .textFont(decoration: .solid)
            Picker(selection: $type,
                   label: Text(title),
                   content: {
                    ForEach(types) { generation in
                        Text(generation.name)
                            .tag(generation)
                    }
            })
            .padding(.trailing)
            .padding(.vertical, padding)
            .pickerStyle(SegmentedPickerStyle())
        }.background(Color.cSection)
    }
}

struct GenerationView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationView()
    }
}
