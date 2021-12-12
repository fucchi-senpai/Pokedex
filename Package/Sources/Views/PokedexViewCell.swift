//
//  PokedexViewCell.swift
//
//
//  Created by Shota Fuchikami on 2021/12/11.
//

import Models
import SwiftUI

// MARK: SwiftUI View

struct PokedexViewCell: View {
    // MARK: Field Variable

    private let pokeApiRepositoryModel: PokeApiRepositoryProtocol
    private let pokemon: Pokemon?
    private let num: Int
    @State private var image: UIImage?

    // MARK: Initialiser

    init(pokeApiRepositoryModel: PokeApiRepositoryProtocol, num: Int, pokemon: Pokemon? = nil) {
        self.pokeApiRepositoryModel = pokeApiRepositoryModel
        self.pokemon = pokemon
        self.num = num
    }

    // MARK: SwiftUI View LifeCycle

    var body: some View {
        if let pokemon = pokemon {
            Group {
                HStack {
                    if let image = image {
                        Image(uiImage: image)
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("No.\(num)")
                        Text(pokemon.name)
                    }
                }.onAppear {
                    self.loadImage(from: pokemon.url)
                }
            }.frame(width: 360, height: 70, alignment: .leading)
        }
    }
}

// MARK: Private methods

extension PokedexViewCell {
    private func loadImage(from url: String) {
        pokeApiRepositoryModel.fetch(from: url) { (info: PokemonInfo?) in
            guard let pokemonDetail = info else {
                return
            }
            self.pokeApiRepositoryModel.download(from: pokemonDetail.sprites.frontDefault) { data in
                guard let data = data else {
                    return
                }
                self.image = UIImage(data: data)
            }
        }
    }
}

// MARK: SwiftUI PreView

struct PokedexViewCell_Previews: PreviewProvider {
    static var previews: some View {
        PokedexViewCell(pokeApiRepositoryModel: PreviewProtocol(), num: 1).previewLayout(.sizeThatFits)
    }

    private struct PreviewProtocol: PokeApiRepositoryProtocol {
        func fetch<T>(from url: String, completion: @escaping (T?) -> Void) where T: Decodable {
            print(#function)
        }

        func download(from url: String, completion: @escaping (Data?) -> Void) {
            print(#function)
        }
    }
}
