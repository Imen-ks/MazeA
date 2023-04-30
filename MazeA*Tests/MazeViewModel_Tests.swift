//
//  MazeViewModel_Tests.swift
//  MazeA*Tests
//
//  Created by Imen Ksouri on 28/04/2023.
//

import XCTest
@testable import MazeA_

@MainActor
final class MazeViewModel_Tests: XCTestCase {
    var bundle: Bundle?
    var map: Map?
    var viewModel_1: Maze?
    var viewModel_2: Maze?
    let rows = Int.random(in: 1...10)
    let columns = Int.random(in: 1...10)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bundle = Bundle(for: Map_Tests.self)
        guard let bundle = bundle else { return }
        map = Map.loadJson(bundle: bundle, fromAppBundle: "MapSampleDataTest")
        guard let map = map else { return }
        viewModel_1 = Maze(map: map)
        
        viewModel_2 = Maze(map: Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns))))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MazeViewModel_init_shouldInitializeAlgorithm() {
        guard let viewModel = viewModel_2 else { return }
        XCTAssertEqual(viewModel.algorithm.maze, viewModel)
    }
    
    func test_MazeViewModel_setStartPoint_shouldSetStartPointAndRemoveWall() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setStartPoint(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(viewModel.map.cells[randomPointX][randomPointY].isStartPoint)
        XCTAssertFalse(viewModel.map.cells[randomPointX][randomPointY].isWall)
    }
    
    func test_MazeViewModel_isStartPoint_shouldReturnTrue() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setStartPoint(atRow: randomPointX, column: randomPointY)
        let isStartPoint = viewModel.isStartPoint(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(isStartPoint)
    }
    
    func test_MazeViewModel_isStartPoint_shouldReturnFalse() { // By default, a MazeCell is set not to be a startPoint
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        if viewModel.map.startPoint != CGPoint(x: randomPointX, y: randomPointY) {
            let isStartPoint = viewModel.isStartPoint(atRow: randomPointX, column: randomPointY)
            XCTAssertFalse(isStartPoint)
        }
    }
    
    func test_MazeViewModel_setGoalPoint_shouldSetGoalPointAndRemoveWall() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setGoalPoint(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(viewModel.map.cells[randomPointX][randomPointY].isGoalPoint)
        XCTAssertFalse(viewModel.map.cells[randomPointX][randomPointY].isWall)
    }
    
    func test_MazeViewModel_isGoalPoint_shouldReturnTrue() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setGoalPoint(atRow: randomPointX, column: randomPointY)
        let isGoalPoint = viewModel.isGoalPoint(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(isGoalPoint)
    }
    
    func test_MazeViewModel_isGoalPoint_shouldReturnFalse() { // By default, a MazeCell is set not to be a goalPoint
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        if viewModel.map.goalPoint != CGPoint(x: randomPointX, y: randomPointY) {
            let isGoalPoint = viewModel.isGoalPoint(atRow: randomPointX, column: randomPointY)
            XCTAssertFalse(isGoalPoint)
        }
    }
    
    func test_MazeViewModel_setWall_shouldSetWall() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setWall(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(viewModel.map.cells[randomPointX][randomPointY].isWall)
    }
    
    func test_MazeViewModel_isWall_shouldReturnTrue() { // By default, a MazeCell is set to be a wall
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        if viewModel.map.startPoint != CGPoint(x: randomPointX, y: randomPointY) && viewModel.map.goalPoint != CGPoint(x: randomPointX, y: randomPointY) {
            let isWall = viewModel.isWall(atRow: randomPointX, column: randomPointY)
            XCTAssertTrue(isWall)
        }
    }
    
    func test_MazeViewModel_isWall_shouldAlsoReturnTrue() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setWall(atRow: randomPointX, column: randomPointY)
        let isWall = viewModel.isWall(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(isWall)
    }
    
    func test_MazeViewModel_isWall_shouldReturnFalse() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.removeWall(atRow: randomPointX, column: randomPointY)
        let isWall = viewModel.isWall(atRow: randomPointX, column: randomPointY)
        XCTAssertFalse(isWall)
    }
    
    func test_MazeViewModel_removeWall_shouldRemoveWall() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.removeWall(atRow: randomPointX, column: randomPointY)
        XCTAssertFalse(viewModel.map.cells[randomPointX][randomPointY].isWall)
    }
    
    func test_MazeViewModel_setVisited_shouldSetVisited() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.setVisited(atRow: randomPointX, column: randomPointY)
        XCTAssertTrue(viewModel.map.cells[randomPointX][randomPointY].isVisited)
    }
    
    func test_MazeViewModel_resetVisited_shouldResetVisited() {
        guard let viewModel = viewModel_2 else { return }
        let randomPointX = Int.random(in: 0..<rows)
        let randomPointY = Int.random(in: 0..<columns)
        viewModel.resetVisited(atRow: randomPointX, column: randomPointY)
        XCTAssertFalse(viewModel.map.cells[randomPointX][randomPointY].isVisited)
    }
    
    func test_MazeViewModel_adjacentTopCellForCell_shouldReturnPoint() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomRow = Int.random(in: 1..<rows)
            let randomCol = Int.random(in: 0..<columns)
            let point = viewModel.map.cells[randomRow][randomCol].coordinate
            if let point = point {
                XCTAssertEqual(viewModel.adjacentTopCellForCell(atCoordinate: point), viewModel.map.cells[randomRow-1][randomCol].coordinate)
            }
        }
    }
    
    func test_MazeViewModel_adjacentTopCellForCell_shouldReturnNil() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomCol = Int.random(in: 0..<columns)
            let point = viewModel.map.cells[0][randomCol].coordinate
            if let point = point {
                XCTAssertNil(viewModel.adjacentTopCellForCell(atCoordinate: point))
            }
        }
        
        for _ in 1...10 {
            let randomRow = Int.random(in: rows..<rows+10)
            let randomCol = Int.random(in: columns..<columns+10)
            let point = CGPoint(x: randomRow, y: randomCol)
            XCTAssertNil(viewModel.adjacentTopCellForCell(atCoordinate: point))
        }
    }
    
    func test_MazeViewModel_adjacentLeftCellForCell_shouldReturnPoint() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomRow = Int.random(in: 0..<rows)
            let randomCol = Int.random(in: 1..<columns)
            let point = viewModel.map.cells[randomRow][randomCol].coordinate
            if let point = point {
                XCTAssertEqual(viewModel.adjacentLeftCellForCell(atCoordinate: point), viewModel.map.cells[randomRow][randomCol-1].coordinate)
            }
        }
    }
    
    func test_MazeViewModel_adjacentLeftCellForCell_shouldReturnNil() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomRow = Int.random(in: 0..<rows)
            let point = viewModel.map.cells[randomRow][0].coordinate
            if let point = point {
                XCTAssertNil(viewModel.adjacentLeftCellForCell(atCoordinate: point))
            }
        }
        
        for _ in 1...10 {
            let randomRow = Int.random(in: rows..<rows+10)
            let randomCol = Int.random(in: columns..<columns+10)
            let point = CGPoint(x: randomRow, y: randomCol)
            XCTAssertNil(viewModel.adjacentLeftCellForCell(atCoordinate: point))
        }
    }
    
    func test_MazeViewModel_adjacentBottomCellForCell_shouldReturnPoint() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomRow = Int.random(in: 0..<rows-1)
            let randomCol = Int.random(in: 0..<columns)
            let point = viewModel.map.cells[randomRow][randomCol].coordinate
            if let point = point {
                XCTAssertEqual(viewModel.adjacentBottomCellForCell(atCoordinate: point), viewModel.map.cells[randomRow+1][randomCol].coordinate)
            }
        }
    }
    
    func test_MazeViewModel_adjacentBottomCellForCell_shouldReturnNil() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomCol = Int.random(in: 0..<columns)
            let point = viewModel.map.cells[rows-1][randomCol].coordinate
            if let point = point {
                XCTAssertNil(viewModel.adjacentBottomCellForCell(atCoordinate: point))
            }
        }
        
        for _ in 1...10 {
            let randomRow = Int.random(in: rows..<rows+10)
            let randomCol = Int.random(in: columns..<columns+10)
            let point = CGPoint(x: randomRow, y: randomCol)
            XCTAssertNil(viewModel.adjacentBottomCellForCell(atCoordinate: point))
        }
    }
    
    func test_MazeViewModel_adjacentRightCellForCell_shouldReturnPoint() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomRow = Int.random(in: 0..<rows)
            let randomCol = Int.random(in: 1..<columns-1)
            let point = viewModel.map.cells[randomRow][randomCol].coordinate
            if let point = point {
                XCTAssertEqual(viewModel.adjacentRightCellForCell(atCoordinate: point), viewModel.map.cells[randomRow][randomCol+1].coordinate)
            }
        }
    }
    
    func test_MazeViewModel_adjacentRightCellForCell_shouldReturnNil() {
        guard let viewModel = viewModel_1 else { return }
        let rows = viewModel.map.rows
        let columns = viewModel.map.columns
        for _ in 1...10 {
            let randomRow = Int.random(in: 0..<rows)
            let point = viewModel.map.cells[randomRow][columns-1].coordinate
            if let point = point {
                XCTAssertNil(viewModel.adjacentRightCellForCell(atCoordinate: point))
            }
        }
        
        for _ in 1...10 {
            let randomRow = Int.random(in: rows..<rows+10)
            let randomCol = Int.random(in: columns..<columns+10)
            let point = CGPoint(x: randomRow, y: randomCol)
            XCTAssertNil(viewModel.adjacentRightCellForCell(atCoordinate: point))
        }
    }
    
    func test_MazeViewModel_customizeMazeWith_shouldReturnMazeFromInjectedMap() {
        guard let viewModel1 = viewModel_1, let viewModel2 = viewModel_2 else { return }
        let randomNum = Int.random(in: 1...100)
        let map = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
        let maze1 = viewModel1.customizeMazeWith(map: map, rows: randomNum, columns: randomNum, startPoint: nil, goalPoint: nil)
        let maze2 = viewModel2.customizeMazeWith(map: map, rows: randomNum, columns: randomNum, startPoint: nil, goalPoint: nil)
        XCTAssertEqual(map, maze1.map)
        XCTAssertEqual(map, maze2.map)
        XCTAssertEqual(maze1.map, maze2.map)
    }
    
    func test_MazeViewModel_customizeMazeWith_shouldReturnNewMazeFromInjectedValuesWithDefaultStartAndGoalPoints() {
        guard let viewModel1 = viewModel_1, let viewModel2 = viewModel_2 else { return }
        let randomRows = Int.random(in: 1...100)
        let randomCols = Int.random(in: 1...100)
        let maze1 = viewModel1.customizeMazeWith(map: nil, rows: randomRows, columns: randomCols, startPoint: nil, goalPoint: nil)
        let maze2 = viewModel2.customizeMazeWith(map: nil, rows: randomRows, columns: randomCols, startPoint: nil, goalPoint: nil)
        XCTAssertEqual(maze1.map.startPoint, CGPoint(x: 0, y: 0))
        XCTAssertEqual(maze1.map.goalPoint, CGPoint(x: 0, y: 0))
        XCTAssertEqual(maze2.map.startPoint, CGPoint(x: 0, y: 0))
        XCTAssertEqual(maze2.map.goalPoint, CGPoint(x: 0, y: 0))
        XCTAssertEqual(maze1.map.rows, maze2.map.rows)
        XCTAssertEqual(maze1.map.columns, maze2.map.columns)
        XCTAssertNotEqual(maze1.map.id, maze2.map.id)
    }
    
    func test_MazeViewModel_customizeMazeWith_shouldReturnNewMazeFromInjectedValuesWithCustomizedStartAndGoalPoints() {
        guard let viewModel1 = viewModel_1, let viewModel2 = viewModel_2 else { return }
        let randomRows = Int.random(in: 1...100)
        let randomCols = Int.random(in: 1...100)
        let startPoint = CGPoint(x: Int.random(in: 0..<randomRows), y: Int.random(in: 0..<randomCols))
        let goalPoint = CGPoint(x: Int.random(in: 0..<randomRows), y: Int.random(in: 0..<randomCols))
        let maze1 = viewModel1.customizeMazeWith(map: nil, rows: randomRows, columns: randomCols, startPoint: startPoint, goalPoint: goalPoint)
        let maze2 = viewModel2.customizeMazeWith(map: nil, rows: randomRows, columns: randomCols, startPoint: startPoint, goalPoint: goalPoint)
        XCTAssertEqual(maze1.map.startPoint, startPoint)
        XCTAssertEqual(maze1.map.goalPoint, goalPoint)
        XCTAssertEqual(maze2.map.startPoint, startPoint)
        XCTAssertEqual(maze2.map.goalPoint, goalPoint)
        XCTAssertEqual(maze1.map.startPoint, maze2.map.startPoint)
        XCTAssertEqual(maze1.map.goalPoint, maze2.map.goalPoint)
        XCTAssertNotEqual(maze1.map.id, maze2.map.id)
    }
    
    func test_MazeViewModel_loadMaze_shouldInitMapFromFile() {
        guard let viewModel1 = viewModel_1, let viewModel2 = viewModel_2 else { return }
        let fileName = UUID().uuidString
        let url = FileStorage.getUrl(fileName)
        defer {
            do {
                try FileManager.default.removeItem(at: url)
            }
            catch {
                print(String(describing: error))
            }
        }
        let mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
        FileStorage.store(mockObject, as: fileName)
        viewModel1.loadMaze(fileName)
        viewModel2.loadMaze(fileName)
        XCTAssertEqual(viewModel1.map, mockObject)
        XCTAssertEqual(viewModel1.map, mockObject)
        XCTAssertEqual(viewModel1.map, viewModel2.map)
    }
    
    func test_MazeViewModel_createMazeWith_shouldInitNewMaPFromInjectedValues() {
        guard let viewModel1 = viewModel_1, let viewModel2 = viewModel_2 else { return }
        let randomRows = Int.random(in: 1...100)
        let randomCols = Int.random(in: 1...100)
        let startPoint = CGPoint(x: Int.random(in: 0..<randomRows), y: Int.random(in: 0..<randomCols))
        let goalPoint = CGPoint(x: Int.random(in: 0..<randomRows), y: Int.random(in: 0..<randomCols))
        viewModel1.createMazeWith(rows: randomRows, columns: randomCols, startPoint: startPoint, goalPoint: goalPoint)
        viewModel2.createMazeWith(rows: randomRows, columns: randomCols, startPoint: startPoint, goalPoint: goalPoint)
        XCTAssertEqual(viewModel1.map.rows, viewModel2.map.rows)
        XCTAssertEqual(viewModel1.map.columns, viewModel2.map.columns)
        XCTAssertEqual(viewModel1.map.startPoint, viewModel2.map.startPoint)
        XCTAssertEqual(viewModel1.map.goalPoint, viewModel2.map.goalPoint)
        XCTAssertNotEqual(viewModel1.map.id, viewModel2.map.id)
    }
    
    func test_MazeViewModel_displaySolution_shouldDisplayExistingSolution() {
        guard let viewModel = viewModel_1 else { return }
        let solution = viewModel.displaySolution()
        XCTAssertEqual(solution, "(2, 3), (2, 4), (2, 5), (3, 5), (4, 5), (4, 6), (4, 7), (5, 7), (6, 7), (7, 7), (8, 7), (9, 7), (10, 7), (10, 8), (11, 8), (12, 8), (13, 8), (14, 8), (15, 8), (15, 9)")
    }
    
    func test_MazeViewModel_displaySolution_shouldNotDisplayExistingSolution() {
        guard let viewModel = viewModel_2 else { return }
        if viewModel.adjacentTopCellForCell(atCoordinate: viewModel.map.startPoint) != viewModel.map.goalPoint && viewModel.adjacentLeftCellForCell(atCoordinate: viewModel.map.startPoint) != viewModel.map.goalPoint && viewModel.adjacentBottomCellForCell(atCoordinate: viewModel.map.startPoint) != viewModel.map.goalPoint && viewModel.adjacentLeftCellForCell(atCoordinate: viewModel.map.startPoint) != viewModel.map.goalPoint {
            let solution = viewModel.displaySolution()
            XCTAssertEqual(solution, "There is no solution to this maze")
        }
    }
    
    func test_MazeViewModel_getSolution_shouldUpdatePointsInSolutionPath() async {
        guard let viewModel = viewModel_1 else { return }
        let solution = [CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3), CGPoint(x: 1, y: 4), CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4), CGPoint(x: 3, y: 5), CGPoint(x: 3, y: 6), CGPoint(x: 4, y: 6), CGPoint(x: 5, y: 6), CGPoint(x: 6, y: 6), CGPoint(x: 7, y: 6), CGPoint(x: 8, y: 6), CGPoint(x: 9, y: 6), CGPoint(x: 9, y: 7), CGPoint(x: 10, y: 7), CGPoint(x: 11, y: 7), CGPoint(x: 12, y: 7), CGPoint(x: 13, y: 7), CGPoint(x: 14, y: 7), viewModel.map.goalPoint]
        await viewModel.getSolution()
        XCTAssertEqual(solution, viewModel.solution)
        if let computedSolution = viewModel.solution {
            for point in computedSolution {
                XCTAssertTrue(viewModel.map.cells[Int(point.x)][Int(point.y)].isVisited)
            }
        }
    }
    
    func test_MazeViewModel_resetSolution_shouldEmptyPointsInSolutionPath() async {
        guard let viewModel = viewModel_1 else { return }
        await viewModel.getSolution()
        let computedSolution = viewModel.solution
        viewModel.reset()
        XCTAssertNil(viewModel.solution)
        if let computedSolution = computedSolution {
            for point in computedSolution {
                XCTAssertFalse(viewModel.map.cells[Int(point.x)][Int(point.y)].isVisited)
            }
        }
    }
}
