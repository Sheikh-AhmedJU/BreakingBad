//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Sheikh Ahmed on 25/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
@testable import BreakingBad

class BreakingBadTests: XCTestCase {
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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            let data = try JSONDecoder().decode([Character].self, from: getData(name: "data"))
            characters = data
        } catch (let err){
            print(err.localizedDescription)
        }
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testLoadMockData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(characters.count > 0)
    }
    

   

}
