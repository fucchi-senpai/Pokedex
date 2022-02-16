//
//  Pokemon.swift
//
//
//  Created by Shota Fuchikami on 2021/12/11.
//

import Foundation

public struct Response: Codable {
    public let results: [Pokemon]
}

public struct Pokemon: Codable {
    public let name: String
    public let url: String
}

public struct PokemonInfo: Codable {
    public let sprites: Sprites
}

public struct Sprites: Codable {
    public let frontDefault: String

    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_detault"
    }
}
