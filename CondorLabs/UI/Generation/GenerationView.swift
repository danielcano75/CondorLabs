//
//  GenerationView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI

struct GenerationView: View {
    private let size: CGFloat = 30
    
    @ObservedObject var viewModel = GenerationViewModel()
    @State var detail: Bool = false
    @State var pokemon: Pokemon = .init()
    @State var active: Int? = nil
    @State var vote: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.red,
                                                                 .font : UIFont(name: DecorationType.solid.rawValue,
                                                                                size: FontSizeType.large.rawValue)!]
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    ZStack {
                        VStack {
                            if $viewModel.pokemon.wrappedValue.isEmpty {
                                EmptyStateView(title: "No pokemon found, please try again later")
                            } else {
                                SearchBar(text: $viewModel.search,
                                          placeholder: "Search pokemon")
                                LazyVStack(pinnedViews: [.sectionHeaders]) {
                                    Section(header: HeaderView(title: $viewModel.name,
                                                               type: $viewModel.type,
                                                               types: $viewModel.types)) {
                                        ForEach(viewModel.pokemon) { pokemon in
                                            NavigationLink(destination: PokemonDetailView(type: viewModel.type.generation,
                                                                                          id: pokemon.getId()),
                                                           tag: pokemon.getId(),
                                                           selection: $active) {
                                                PokemonView(type: viewModel.type.generation,
                                                            pokemon: pokemon) {
                                                    self.pokemon = pokemon
                                                    active = pokemon.getId()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .disabled(vote)
                .onAppear {
                    viewModel.search = ""
                    active = nil
                    viewModel.get()
                }
                .navigationBarTitle(Text("Pokédex"),
                                    displayMode: .automatic)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            vote = !viewModel.random().isEmpty
                                        }) {
                                            Image("Vote")
                                                .renderingMode(.original)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: size,
                                                       height: size)
                                        }
                )
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = UIColor.cBackground
                    nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.cText ?? .white,
                                                            .font: UIFont(name: DecorationType.regular.rawValue, size: FontSizeType.title.rawValue)!]
                })
            }
            if $vote.wrappedValue {
                if !viewModel.random().isEmpty {
                    VoteView(vote: $vote,
                             type: viewModel.type.generation,
                             pokemons: viewModel.random())
                }
            }
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
