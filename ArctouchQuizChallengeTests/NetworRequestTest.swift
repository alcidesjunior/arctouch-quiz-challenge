//
//  ArctouchQuizChallengeTests.swift
//  ArctouchQuizChallengeTests
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import XCTest
@testable import ArctouchQuizChallenge

class NetworkRequest: XCTestCase {

    var networkManager: NetWorkManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.networkManager = NetWorkManager()
    }
    
    func testRequest_succes(){
        self.networkManager.get(T: QuizModel.self, service: .quiz) { (result) in
            switch result{
            case .success(let quizAnswers):
                if let _ = quizAnswers.answer{
                    XCTestExpectation(description: "Request was success!").fulfill()
                }
            case .failure(let error):
                XCTFail("Failure \(error)")
            }
        }
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
