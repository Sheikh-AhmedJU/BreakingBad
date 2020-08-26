//
//  CharacterViewModelTests.swift
//  BreakingBadTests
//
//  Created by Sheikh Ahmed on 26/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
@testable import BreakingBad

class CharacterViewModelTests: XCTestCase {
    var viewModel: CharacterViewModel?
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
        do {
            if let character = try getCharacters().first {
                viewModel = CharacterViewModel(character: character)
            }
        } catch (_) {
            
        }
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testName() throws {
        let name = viewModel?.name ?? ""
        XCTAssertEqual(name, "Walter White")
    }
    func testOccupation() throws {
        let occupation = viewModel?.occupation ?? []
        XCTAssertEqual(occupation, ["High School Chemistry Teacher", "Meth King Pin"])
    }
    func testImage() throws {
        let image = viewModel?.image ?? ""
        XCTAssertEqual(image, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
    }
    func testId() throws {
        let id = viewModel?.id ?? 0
        XCTAssertEqual(id, 1)
    }
    func testStatus() throws {
        let status = viewModel?.status ?? ""
        XCTAssertEqual(status, "Presumed dead")
    }
    func testNickName() throws {
        let nickName = viewModel?.nickName ?? ""
        XCTAssertEqual(nickName, "Heisenberg")
    }
    func testSeasons() throws {
        let seasons = viewModel?.seasons ?? []
        XCTAssertEqual(seasons, [1,2,3,4,5])
    }
    
    func testGetHeaderForDetailScreen(){
        var header = viewModel?.getHeader(screen: .DetailScreen, section: 0) ?? ""
        XCTAssertEqual(header, "Name")
        header = viewModel?.getHeader(screen: .DetailScreen, section: 1) ?? ""
        XCTAssertEqual(header, "Occupation")
        header = viewModel?.getHeader(screen: .DetailScreen, section: 2) ?? ""
        XCTAssertEqual(header, "Status")
        header = viewModel?.getHeader(screen: .DetailScreen, section: 3) ?? ""
        XCTAssertEqual(header, "Nickname")
        header = viewModel?.getHeader(screen: .DetailScreen, section: 4) ?? ""
        XCTAssertEqual(header, "Season appearance")
        let nilHeader = viewModel?.getHeader(screen: .DetailScreen, section: 5)
        XCTAssertNil(nilHeader)
    }
    func testCellDataForDetailScreen(){
        var header = viewModel?.getCellData(screen: .DetailScreen, section: 0)
        XCTAssertEqual(header, "Walter White")
        header = viewModel?.getCellData(screen: .DetailScreen, section: 1) ?? ""
        XCTAssertEqual(header, "High School Chemistry Teacher\nMeth King Pin")
        header = viewModel?.getCellData(screen: .DetailScreen, section: 2) ?? ""
        XCTAssertEqual(header, "Presumed dead")
        header = viewModel?.getCellData(screen: .DetailScreen, section: 3) ?? ""
        XCTAssertEqual(header, "Heisenberg")
        header = viewModel?.getCellData(screen: .DetailScreen, section: 4) ?? ""
        XCTAssertEqual(header, "1, 2, 3, 4, 5")
        header = viewModel?.getCellData(screen: .DetailScreen, section: 5)
        XCTAssertNil(header)
    }
    
}
