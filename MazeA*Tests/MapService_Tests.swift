//
//  MapService_Tests.swift
//  MazeA*Tests
//
//  Created by Imen Ksouri on 30/04/2023.
//

import XCTest
@testable import MazeA_

final class MapService_Tests: XCTestCase {
    var mapService = MapService()
    var urls: [URL] = []
    var rows = Int.random(in: 1...10)
    var columns = Int.random(in: 1...10)
    let randomCount = Int.random(in: 1...50)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        if !urls.isEmpty {
            do {
                for url in urls {
                    try FileManager.default.removeItem(at: url)
                }
            }
            catch { print(String(describing: error)) }
        }
    }

    func test_MapService_save_shouldStoreMapAsFileInDocumentsDirectory() {
        for _ in 1...randomCount {
            let mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
            let fileName = "map_\(mockObject.id)"
            let url = FileStorage.getUrl(fileName)
            urls.append(url)
            mapService.save(map: mockObject)
            if let contentsOfDirectory = FileStorage.read() {
                XCTAssertTrue(contentsOfDirectory.contains(fileName))
            }
        }
    }
    
    func test_MapService_load_shouldLoadMapFromFilesInDocumentsDirectoryAndUpdateList() {
        var maps = [String: Map]()
        for _ in 1...randomCount {
            let mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
            let fileName = "map_\(mockObject.id)"
            maps[fileName] = mockObject
            let url = FileStorage.getUrl(fileName)
            urls.append(url)
            mapService.save(map: mockObject)
        }
        mapService.load()
        let fileNames = Array(maps.keys)
        for fileName in fileNames {
            XCTAssertEqual(maps[fileName], mapService.maps[fileName])
        }
    }
    
    func test_MapService_remove_shouldRemoveMapFilesFromDocumentsDirectory() {
        for _ in 1...randomCount {
            let mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
            let fileName = "map_\(mockObject.id)"
            mapService.save(map: mockObject)
            mapService.remove(fileName)
        }
        mapService.load()
        XCTAssertEqual(mapService.maps, [:])
    }
    
    func test_MapService_clear_shouldClearDocumentsDirectory() {
        for _ in 1...randomCount {
            let mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
            mapService.save(map: mockObject)
        }
        mapService.clear()
        mapService.load()
        XCTAssertEqual(mapService.maps, [:])
    }
}
