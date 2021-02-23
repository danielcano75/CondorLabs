//
//  PokeCardView.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeCardView: View {
    private let vertical: CGFloat = 5
    private let shadow: CGFloat = 5
    private let corner: CGFloat = 5
    private let spacing: CGFloat = 5
    private let padding: CGFloat = 10
    private let size: CGFloat = 35
    private let action: CGFloat = 55
    
    @ObservedObject var viewModel: PokeCardViewModel
    @State private var translation: CGSize = .zero
    @State private var swipe: SwipeStatus = .none
    private var onRemove: (SwipeStatus, PokemonDetail) -> Void
    private var threshold: CGFloat = 0.5
    
    init(type: GenerationType,
         id: Int,
         onRemove: @escaping (SwipeStatus, PokemonDetail) -> ()) {
        viewModel = PokeCardViewModel(type: type,
                                      id: id)
        self.onRemove = onRemove
    }
    
    private func getPercentage(_ geometry: GeometryProxy,
                               from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading) {
                    ZStack(alignment: swipe == .like ? .topLeading : .topTrailing) {
                        WebImage(url: URL(string: viewModel.pokemon.sprites.other.artwork.artwork))
                            .onSuccess { image, cache in
                            }
                            .renderingMode(.original)
                            .resizable()
                            .placeholder(Image("Pokeball"))
                            .indicator(.activity)
                            .transition(.fade)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.5)
                            .clipped()
                            .padding(.top, padding)
                        switch $swipe.wrappedValue {
                        case .like:
                            Image("BallLike")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: size,
                                       height: size)
                                .padding()
                                .rotationEffect(Angle.degrees(-45))
                        case .dislike:
                            Image("BallDislike")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: size,
                                       height: size)
                                .padding()
                                .rotationEffect(Angle.degrees(45))
                        case .none:
                            EmptyView()
                        }
                    }
                    VStack(alignment: .leading, spacing: spacing) {
                        Text(viewModel.pokemon.name.capitalizingFirstLetter())
                            .font(.title)
                            .bold()
                        HStack {
                            ForEach(viewModel.pokemon.types) { type in
                                Text(type.type.name.capitalizingFirstLetter())
                                    .titleFont(decoration: .bold)
                                    .padding(.vertical, vertical)
                                    .padding(.horizontal, padding)
                                    .background(type.color())
                                    .cornerRadius(corner)
                            }
                        }
                        HStack(spacing: padding) {
                            Text("No.")
                            Text("\(viewModel.pokemon.pokedexId)")
                        }
                    }
                    .padding(.horizontal, padding)
                }
                .onAppear {
                    viewModel.get()
                }
                .titleFont(decoration: .bold)
                .padding(.bottom)
                .background(Color.cBackground)
                .cornerRadius(padding)
                .shadow(radius: shadow)
                .offset(x: translation.width, y: .zero)
                .rotationEffect(.degrees(Double(translation.width / geometry.size.width) * 25),
                                anchor: .bottom)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            translation = value.translation
                            if (getPercentage(geometry, from: value)) >= threshold {
                                swipe = .like
                            } else if getPercentage(geometry, from: value) <= -threshold {
                                swipe = .dislike
                            } else {
                                swipe = .none
                            }
                        }.onEnded { value in
                            if abs(getPercentage(geometry, from: value)) > threshold {
                                onRemove(swipe, viewModel.pokemon)
                            } else {
                                translation = .zero
                            }
                        }
                )
                HStack() {
                    Button(action: {
                        onRemove(.dislike, viewModel.pokemon)
                    }) {
                        Image(systemName: "xmark.square.fill")
                            .font(name: DecorationType.regular.rawValue,
                                  size: action)
                            .padding(.vertical, vertical)
                    }
                    .foregroundColor(.red)
                    .padding(.leading, size)
                    Spacer()
                    Button(action: {
                        onRemove(.like, viewModel.pokemon)
                    }) {
                        Image(systemName: "checkmark.square.fill")
                            .font(name: DecorationType.regular.rawValue,
                                  size: action)
                            .padding(.vertical, vertical)
                    }.foregroundColor(.green)
                    .padding(.trailing, size)
                }
                .frame(width: geometry.size.width)
                .background(Color.cBackground)
                .cornerRadius(padding)
                .shadow(radius: shadow)
                .padding(.top, size)
            }
            
        }
    }
}

struct PokeCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokeCardView(type: .i,
                     id: 1) { _, _ in
        }
        
    }
}
