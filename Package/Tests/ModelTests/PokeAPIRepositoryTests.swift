//
//  PokeAPIRepositoryTests.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import XCTest
@testable import Models

final class PokeAPIRepositoryTests: XCTestCase {
    
    // MARK: - Field Property
    
    private let repository = PokeAPIRepository()
    
    // MARK: - Life Cycle

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    // MARK: - Test Methods

    func test_fetch_api_limit_151_count_success() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        repository.fetch(from: urlString, success: { (data: Response?) in
            XCTAssertEqual(151, data?.results.count)
            fetchAPIExpectation?.fulfill()
        }, failure: { _ in })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetch_api_limit_151_pokemon_success() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        let expectation = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        repository.fetch(from: urlString, success: { (data: Response?) in
            XCTAssertEqual(expectation, data?.results.first)
            fetchAPIExpectation?.fulfill()
        }, failure: { _ in })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetch_api_pokemon_detail_info_success() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        let urlString = "https://pokeapi.co/api/v2/pokemon/1/"
        let sprites = Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        let expectation = PokemonInfo(sprites: sprites)
        repository.fetch(from: urlString, success: { (data: PokemonInfo?) in
            XCTAssertEqual(expectation, data)
            fetchAPIExpectation?.fulfill()
        }, failure: { _ in })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetch_api_invalid_url() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        let urlString = ""
        repository.fetch(from: urlString, success: { (_: Response?) in }, failure: { (error: Error) in
            XCTAssertNotNil(error)
            fetchAPIExpectation?.fulfill()
        })
        waitForExpectations(timeout: 0.1, handler: nil)
    }

}
