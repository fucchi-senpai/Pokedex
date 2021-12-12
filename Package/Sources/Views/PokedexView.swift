//
//  PokedexView.swift
//
//
//  Created by Shota Fuchikami on 2021/12/11.
//

import Models
import SwiftUI

// MARK: SwiftUI View

public struct PokedexView: View {
    // MARK: Field Variable

    private let pokeApiRepositoryModel: PokeApiRepositoryProtocol
    @State private var pokemon: [Pokemon]?

    // MARK: Initialiser

    public init(pokeApiRepositoryModel: PokeApiRepositoryProtocol) {
        self.pokeApiRepositoryModel = pokeApiRepositoryModel
    }

    // MARK: SwiftUI View LifeCycle

    public var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: CGFloat(0)) {
                if let pokemon = pokemon {
                    ForEach(0..<pokemon.count) { index in
                        PokedexViewCell(pokeApiRepositoryModel: self.pokeApiRepositoryModel, num: index + 1, pokemon: pokemon[index])
                    }
                }
            }
        }.onAppear {
            self.loadData()
        }
    }
}

// MARK: Private methods

extension PokedexView {
    private func loadData() {
        pokeApiRepositoryModel.fetch(from: "https://pokeapi.co/api/v2/pokemon?limit=151") { (response: Response?) in
            pokemon = response?.results
        }
    }
}

// MARK: SwiftUI PreView

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PreviewProtocol()
        Group {
            PokedexView(pokeApiRepositoryModel: model).preferredColorScheme(.light).previewLayout(.device)
            PokedexView(pokeApiRepositoryModel: model).preferredColorScheme(.dark).previewLayout(.device)
        }
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
