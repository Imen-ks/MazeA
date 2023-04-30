//
//  Step_Tests.swift
//  MazeA*Tests
//
//  Created by Imen Ksouri on 29/04/2023.
//

import XCTest
@testable import MazeA_

final class Step_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Step_setPreviousStep_shouldSetParentStepToCurrentStep() {
        let step = Step(coordinate: CGPoint(x: Int.random(in: 0..<10), y: Int.random(in: 0..<10)))
        let previousStep = Step(coordinate: CGPoint(x: Int.random(in: 0..<10), y: Int.random(in: 0..<10)))
        step.setPreviousStep(previousStep: previousStep)
        XCTAssertEqual(step.previousStep, previousStep)
    }
    
    func test_Step_setPreviousStep_shouldIncrementGScore() {
        let step = Step(coordinate: CGPoint(x: Int.random(in: 0..<10), y: Int.random(in: 0..<10)))
        let previousStep = Step(coordinate: CGPoint(x: Int.random(in: 0..<10), y: Int.random(in: 0..<10)))
        step.setPreviousStep(previousStep: previousStep)
        XCTAssertEqual(previousStep.gScore, 0)
        XCTAssertEqual(step.gScore, 1)
        previousStep.setPreviousStep(previousStep: step)
        XCTAssertEqual(step.gScore, 1)
        XCTAssertEqual(previousStep.gScore, 2)
        step.setPreviousStep(previousStep: previousStep)
        XCTAssertEqual(previousStep.gScore, 2)
        XCTAssertEqual(step.gScore, 3)

    }
}
