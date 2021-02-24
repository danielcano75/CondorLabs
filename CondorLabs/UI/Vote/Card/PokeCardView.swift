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
        viewModel = PokeCardViewModel(.live,
                                      type: type,
                                      id: id)
        self.onRemove = onRemove
    }
    
    private func getPercentage(_ geometry: GeometryProxy,
                               from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                if $viewModel.pokemon.id.wrappedValue == .zero {
                    EmptyStateView(title: "No pokemon found, please try again later")
                } else {
                    ZStack(alignment: swipe == .like ? .topLeading : .topTrailing) {
                        WebImage(url: URL(string: viewModel.pokemon.sprites.other.artwork.artwork))
                            .onSuccess { image, cache in
                            }
                            .renderingMode(.original)
                            .resizable()
                            .placeholder(Image("Pokeball"))
                            .indicator(.activity)
                            .transition(.fade)
                            .aspectRatio(contentMode: .fit)
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
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: size,
                                       height: size)
                                .foregroundColor(.cText)
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
                    HStack {
                        Button(action: {
                            withAnimation(.linear) {
                                translation.width = -(geometry.size.width - action)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                onRemove(.dislike, viewModel.pokemon)
                            }
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
                            withAnimation(.linear) {
                                translation.width = geometry.size.width - action
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                onRemove(.like, viewModel.pokemon)
                            }
                        }) {
                            Image(systemName: "checkmark.square.fill")
                                .font(name: DecorationType.regular.rawValue,
                                      size: action)
                                .padding(.vertical, vertical)
                        }.foregroundColor(.green)
                        .padding(.trailing, size)
                    }
                    .frame(width: geometry.size.width)
                    .padding(.top)
                }
            }
            .onAppear {
                viewModel.get()
            }
            .disabled(viewModel.pokemon.id == .zero ? true : false)
            .titleFont(decoration: .bold)
            .padding(.bottom)
            .background(Color.cBackground)
            .cornerRadius(padding)
            .shadow(color: .cText,
                    radius: shadow)
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
                            if swipe != .none {
                                onRemove(swipe, viewModel.pokemon)
                            }
                        } else {
                            translation = .zero
                        }
                    }
            )
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
