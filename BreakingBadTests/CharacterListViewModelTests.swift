//
//  CharacterListViewModelTests.swift
//  BreakingBadTests
//
//  Created by Sheikh Ahmed on 26/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
@testable import BreakingBad

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel?
    var characters: Characters = []
    var mockContentData: Data {
        return getData(name: "data")
    }

    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    func getCharacters() throws ->Characters {
        do {
            let data = try JSONDecoder().decode([Character].self, from: mockContentData)
            return data
        } catch (let err){
            print(err.localizedDescription)
        }
        return []
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CharacterListViewModel()
        do {
            viewModel?.characters = try getCharacters()
        } catch (_) {
            
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterCharacterBySeasion() throws {
        var seasion = 1
        var characters = viewModel?.filterSelectedCharacters(season: seasion)
        XCTAssertEqual(characters?.count, 26)
        seasion = 2
        characters = viewModel?.filterSelectedCharacters(season: seasion)
        XCTAssertEqual(characters?.count, 36)
        seasion = 3
        characters = viewModel?.filterSelectedCharacters(season: seasion)
        XCTAssertEqual(characters?.count, 40)
        seasion = 4
        characters = viewModel?.filterSelectedCharacters(season: seasion)
        XCTAssertEqual(characters?.count, 27)
        seasion = 5
        characters = viewModel?.filterSelectedCharacters(season: seasion)
        XCTAssertEqual(characters?.count, 27)
        seasion = 6
        characters = viewModel?.filterSelectedCharacters(season: seasion)
        XCTAssertEqual(characters?.count, 0)
    }
    func testFilterCharacterByName() throws {
        var name = "Walter"
        var characters = viewModel?.filterSelectedCharacters(name: name)
        XCTAssertEqual(characters?.count, 2)
        name = "White"
        characters = viewModel?.filterSelectedCharacters(name: name)
        XCTAssertEqual(characters?.count, 4)
        name = "Bla bla"
        characters = viewModel?.filterSelectedCharacters(name: name)
        XCTAssertEqual(characters?.count, 0)
    }
}
