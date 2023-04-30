//
//  Map_Tests.swift
//  MazeA*Tests
//
//  Created by Imen Ksouri on 29/04/2023.
//

import XCTest
@testable import MazeA_

final class Map_Tests: XCTestCase {
    var url: URL?
    let fileName = UUID().uuidString
    let decoder = JSONDecoder()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        url = FileStorage.getUrl(fileName)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        if let url = url {
            do {
                try FileManager.default.removeItem(at: url)
            }
            catch {
                print(String(describing: error))
            }
        }
    }
    
    func test_Map_loadJson_shouldInitMapFromBundle() {
        let bundle = Bundle(for: Map_Tests.self)
        let map = Map.loadJson(bundle: bundle, fromAppBundle: "MapSampleDataTest")
        XCTAssertEqual(map.id.uuidString, "5C377778-A7D1-49FE-ACE7-123D293AD857")
        XCTAssertEqual(map.rows, 16)
        XCTAssertEqual(map.columns, 9)
        XCTAssertEqual(map.startPoint.x, 2)
        XCTAssertEqual(map.startPoint.y, 2)
        XCTAssertEqual(map.goalPoint.x, 14)
        XCTAssertEqual(map.goalPoint.y, 8)
        XCTAssertEqual(map.cells.flatMap{$0}.count, 16 * 9)

    }

    func test_Map_loadJson_shouldInitMapFromFile() {
        let rows = Int.random(in: 1...10)
        let columns = Int.random(in: 1...10)
        let mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
        FileStorage.store(mockObject, as: fileName)
        let map = Map.loadJson(fromFileSystem: fileName)
        XCTAssertEqual(map, mockObject)
    }

    func test_Map_shouldInitMapFromInjectedValues() {
        let rows = Int.random(in: 1...10)
        let columns = Int.random(in: 1...10)
        let randomStartPoint = CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns))
        let randomGoalPoint = CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns))
        let map = Map(rows: rows, columns: columns, startPoint: randomStartPoint, goalPoint: randomGoalPoint)
        XCTAssertEqual(map.rows, rows)
        XCTAssertEqual(map.columns, columns)
        XCTAssertEqual(map.startPoint, randomStartPoint)
        XCTAssertEqual(map.goalPoint, randomGoalPoint)
        let randomRow = Int.random(in: 0..<rows)
        let randomCol = Int.random(in: 0..<columns)
        XCTAssertEqual(map.cells[randomRow][randomCol].coordinate, CGPoint(x: randomRow, y: randomCol))
    }
}
