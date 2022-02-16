//
//  PokeAPIRepositoryTests.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import XCTest
@testable import Models
@testable import Network

// MARK: - PokeAPIRepositoryTests
final class PokeAPIRepositoryTests: XCTestCase {
    
    // MARK: Field Property
    
    private let repository = PokeAPIRepository()
    
    // MARK: Life Cycle

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    // MARK: Test Methods

    func test_fetch_api_limit_151_count_success() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        repository.fetch(from: PokeLimitURLRequestTests(), success: { (data: Response?) in
            XCTAssertEqual(151, data?.results.count)
            fetchAPIExpectation?.fulfill()
        }, failure: { _ in })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetch_api_limit_151_pokemon_success() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        let expectation = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        repository.fetch(from: PokeLimitURLRequestTests(), success: { (data: Response?) in
            XCTAssertEqual(expectation, data?.results.first)
            fetchAPIExpectation?.fulfill()
        }, failure: { _ in })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetch_api_pokemon_detail_info_success() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        let sprites = Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        let expectation = PokemonInfo(sprites: sprites)
        repository.fetch(from: PokeInfoURLRequestTests(), success: { (data: PokemonInfo?) in
            XCTAssertEqual(expectation, data)
            fetchAPIExpectation?.fulfill()
        }, failure: { _ in })
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetch_api_invalid_url() {
        let fetchAPIExpectation: XCTestExpectation? = self.expectation(description: "fetch api")
        repository.fetch(from: PokeInvalidURLRequestTests(), success: { (_: Response?) in }, failure: { (error: Error) in
            XCTAssertNotNil(error)
            fetchAPIExpectation?.fulfill()
        })
        waitForExpectations(timeout: 0.1, handler: nil)
    }

}

// MARK: - Test URL
private struct PokeLimitURLRequestTests: PokeURLRequestProtocol {
    var urlStr: String {
        return "https://pokeapi.co"
    }
    
    var pathList: [String] {
        return ["api", "v2", "pokemon"]
    }
    
    var parameters: [String: Any]? {
        return ["limit": "151"]
    }
}

private struct PokeInfoURLRequestTests: PokeURLRequestProtocol {
    var urlStr: String {
        return "https://pokeapi.co"
    }
    
    var pathList: [String] {
        return ["api", "v2", "pokemon", "1"]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

private struct PokeInvalidURLRequestTests: PokeURLRequestProtocol {
    var urlStr: String {
        return ""
    }
    
    var pathList: [String] {
        return []
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
