//
//  BadCharacterTableViewCellTests.swift
//  BreakingBadTests
//
//  Created by Sheikh Ahmed on 26/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
@testable import BreakingBad
class BadCharacterTableViewCellTests: XCTestCase {
    var sut: BadCharacterTableViewCell?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: BadCharacterTableViewCell.self)
        guard let cell = bundle.loadNibNamed("BadCharacterTableViewCell", owner: nil)?.first as? BadCharacterTableViewCell else {
            return XCTFail("CustomView nib did not contain a UIView")
         }
        sut = cell
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testLabels() throws {
        let character = Character(charID: 1, name: "Character 1", birthday: nil, occupation: ["Teacher"], img: nil, status: "Alive", nickname: "Nich name 1", appearance: [1, 2, 3], portrayed: nil, category: nil, betterCallSaulAppearance: nil)
        sut?.setupCell(characterViewModel: CharacterViewModel(character: character))
        XCTAssertEqual(sut?.characterName.text, "Character 1")
        XCTAssertNil(sut?.characterImage.image)
    }
}
