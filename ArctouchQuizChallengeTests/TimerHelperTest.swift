//
//  TimerHelperTest.swift
//  ArctouchQuizChallengeTests
//
//  Created by Alcides Junior on 14/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import XCTest
@testable import ArctouchQuizChallenge
class TimerHelperTest: XCTestCase {
    var timerHelper: TimerHelper?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.timerHelper = TimerHelper(totalTime: 4, label: UILabel())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func testStartTimer_started(){
        self.timerHelper?.startTimer()
        XCTAssert(self.timerHelper!.wasStarted)
    }
    
    func testStartTimer_unstarted(){
        XCTAssertFalse(self.timerHelper!.wasStarted)
    }
    
    func testEndTimer(){
        self.timerHelper?.startTimer()
        self.timerHelper?.endTimer()
        testStartTimer_unstarted()
    }
    
    func testIfAttributesAreNotNil(){
        self.timerHelper?.startTimer()
        XCTAssertNotNil(self.timerHelper!.countDown)
        XCTAssertNotNil(self.timerHelper!.totalTime)
        XCTAssertNotNil(self.timerHelper!.currentTime)
        XCTAssertNotNil(self.timerHelper!.label)
        XCTAssertNotNil(self.timerHelper!.wasStarted)
    }
    
    func testTimerFormatted(){
        let time = self.timerHelper!.testTimerFormatted(10)
        print(time)
        XCTAssert(time == "00:10")
    }
    
    func testSetLabelTime(){
        self.timerHelper!.testSetLabel(value: 10)
        XCTAssert(self.timerHelper!.label.text == "00:10")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
