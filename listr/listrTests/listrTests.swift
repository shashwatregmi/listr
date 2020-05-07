//
//  listrTests.swift
//  listrTests
//
//  Created by Regmi on 2020-05-04.
//  Copyright © 2020 Regmi. All rights reserved.
//

import XCTest
@testable import listr

class listrTests: XCTestCase {
    func testTaskInitializationSucceeds() {
        // Zero rating
        let zeroPriorityTask = Task.init(name: "Zero", img: nil, priority: 0)
        XCTAssertNotNil(zeroPriorityTask)
         
        // Highest positive rating
        let maxPriorityTask = Task.init(name: "Zero", img: nil, priority: 5)
        XCTAssertNotNil(maxPriorityTask)
    }
    
    func testMealInitializationFails() {
        // Negative rating
        let negativePriorityTask = Task.init(name: "Negative", img: nil, priority: -1)
        XCTAssertNil(negativePriorityTask)
         
        // Empty String
        let emptyStringTask = Task.init(name: "", img: nil, priority: 0)
        XCTAssertNil(emptyStringTask)
        
        let largePriorityTask = Task.init(name: "Large", img: nil, priority: 6)
        XCTAssertNil(largePriorityTask)
    }

}
