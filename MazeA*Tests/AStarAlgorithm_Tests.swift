//
//  AStarAlgorithm_Tests.swift
//  MazeA*Tests
//
//  Created by Imen Ksouri on 29/04/2023.
//

import XCTest
@testable import MazeA_

final class AStarAlgorithm_Tests: XCTestCase {
    var algorithm = AStarAlgorithm()
    var maze: Maze?
    var map: Map?

    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        map = Map(rows: 8, columns: 8, startPoint: CGPoint(x: 1, y: 1), goalPoint: CGPoint(x: 6, y: 6))
        map?.cells[1][1].isWall = false // removing wall at startPoint
        map?.cells[1][2].isWall = false
        map?.cells[1][3].isWall = false
        map?.cells[1][5].isWall = false
        map?.cells[1][6].isWall = false
        map?.cells[2][1].isWall = false
        map?.cells[2][6].isWall = false
        map?.cells[2][7].isWall = false
        map?.cells[3][1].isWall = false
        map?.cells[3][2].isWall = false
        map?.cells[3][3].isWall = false
        map?.cells[3][4].isWall = false
        map?.cells[3][5].isWall = false
        map?.cells[3][6].isWall = false
        map?.cells[4][2].isWall = false
        map?.cells[4][4].isWall = false
        map?.cells[4][6].isWall = false
        map?.cells[5][1].isWall = false
        map?.cells[5][2].isWall = false
        map?.cells[5][4].isWall = false
        map?.cells[6][1].isWall = false
        map?.cells[6][4].isWall = false
        map?.cells[6][5].isWall = false
        map?.cells[6][6].isWall = false // removing wall at goalPoint
        
        // ------------------------------------ //
        //  X ---> Blocked (isWall = true)      //
        //  O ---> Empty (isWall = false)       //
        //  S ---> Start (isStartPoint = true)  //
        //  G ---> Goal (isGoalPoint = true)    //
        // ------------------------------------ //
        
        // Map rendered from the code above :
        
        // --------------- //
        // X X X X X X X X //
        // X S O O X O O X //
        // X O X X X X O O //
        // X O O O O O O X //
        // X X O X O X O X //
        // X O O X O X X X //
        // X O X X O O G X //
        // X X X X X X X X //
        // --------------- //
        
        // Initializing a maze from this map :
        maze = Maze(map: map!)
        algorithm.maze = maze
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_manhattanDistance_shouldReturnCheapestPathFromNtoGoal() {
        guard let map = map else { return }
        let distance = algorithm.manhattanDistance(from: map.startPoint, to: map.goalPoint)
        XCTAssertEqual(distance, 10)
    }
    
    func test_AStarAlgorithm_insertStep_shouldInsertStepToOpenList() {
        guard let map = map else { return }
        let step1 = Step(coordinate: map.startPoint)
        let step2 = Step(coordinate: CGPoint(x: Int.random(in: 0..<10), y: Int.random(in: 0..<10)))
        algorithm.insertStep(step: step1)
        algorithm.insertStep(step: step2)
        XCTAssertTrue(algorithm.openList.contains(step1))
        XCTAssertTrue(algorithm.openList.contains(step2))
    }
    
    @MainActor func test_AStarAlgorithm_validAdjacentCoordForPoint_shouldReturnAdjacentPointsThatAreNotWalls() {
        let point1 = algorithm.maze?.map.cells[1][4].coordinate
        let point2 = algorithm.maze?.map.cells[3][4].coordinate
        let point3 = algorithm.maze?.map.cells[5][7].coordinate
        if let point1 = point1, let point2 = point2, let point3 = point3 {
            let validPointsForPoint1 = algorithm.validAdjacentCoordForPoint(atCoordinate: point1)
            let validPointsForPoint2 = algorithm.validAdjacentCoordForPoint(atCoordinate: point2)
            let validPointsForPoint3 = algorithm.validAdjacentCoordForPoint(atCoordinate: point3)
            XCTAssertEqual(validPointsForPoint1, [CGPoint(x: 1, y: 3), CGPoint(x: 1, y: 5)])
            XCTAssertEqual(validPointsForPoint2, [CGPoint(x: 3, y: 3), CGPoint(x: 4, y: 4), CGPoint(x: 3, y: 5)])
            XCTAssertEqual(validPointsForPoint3, [])
        }
    }
    
    func test_AStarAlgorithm_getShortestPath_shouldLoopThroughPreviousStepsAndReturnPath() {
        guard let map = map else { return }
        let point1 = map.startPoint
        let point2 = map.cells[2][1].coordinate
        let point3 = map.cells[3][1].coordinate
        let point4 = map.cells[3][2].coordinate
        let point5 = map.cells[3][3].coordinate
        let point6 = map.cells[3][4].coordinate
        let point7 = map.cells[4][4].coordinate
        let point8 = map.cells[5][4].coordinate
        let point9 = map.cells[6][4].coordinate
        let point10 = map.cells[6][5].coordinate
        let point11 = map.goalPoint
        if let point2 = point2, let point3 = point3, let point4 = point4, let point5 = point5, let point6 = point6, let point7 = point7, let point8 = point8, let point9 = point9, let point10 = point10 {
            let step1 = Step(coordinate: point1)
            let step2 = Step(coordinate: point2)
            step2.previousStep = step1
            let step3 = Step(coordinate: point3)
            step3.previousStep = step2
            let step4 = Step(coordinate: point4)
            step4.previousStep = step3
            let step5 = Step(coordinate: point5)
            step5.previousStep = step4
            let step6 = Step(coordinate: point6)
            step6.previousStep = step5
            let step7 = Step(coordinate: point7)
            step7.previousStep = step6
            let step8 = Step(coordinate: point8)
            step8.previousStep = step7
            let step9 = Step(coordinate: point9)
            step9.previousStep = step8
            let step10 = Step(coordinate: point10)
            step10.previousStep = step9
            let step11 = Step(coordinate: point11)
            step11.previousStep = step10
            let shortestPath = algorithm.getShortestPath(currentStep: step11)
            XCTAssertEqual(shortestPath, [CGPoint(x: 2, y: 1), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 4), CGPoint(x: 4, y: 4), CGPoint(x: 5, y: 4), CGPoint(x: 6, y: 4), CGPoint(x: 6, y: 5), map.goalPoint])
        }
    }
    
    @MainActor func test_AStarAlgorithm_shortestPath_shouldReturnShortestPath() {
        let startPoint = algorithm.maze?.map.startPoint
        let goalPoint = algorithm.maze?.map.goalPoint
        if let startPoint = startPoint, let goalPoint = goalPoint {
            let shortestPath = algorithm.shortestPath(from: startPoint, to: goalPoint)
            XCTAssertEqual(shortestPath, [CGPoint(x: 2, y: 1), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 4), CGPoint(x: 4, y: 4), CGPoint(x: 5, y: 4), CGPoint(x: 6, y: 4), CGPoint(x: 6, y: 5), goalPoint])
        }
    }
}
