//
//  FileStorage_Tests.swift
//  MazeA*Tests
//
//  Created by Imen Ksouri on 28/04/2023.
//

import XCTest
@testable import MazeA_

extension FileManager {
    fileprivate static var documentDirectoryUrl: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

final class FileStorage_Tests: XCTestCase {
    let documentDirectory =  FileManager.documentDirectoryUrl
    var url: URL?
    var urls: [URL] = []
    let fileName = UUID().uuidString
    var rows = Int.random(in: 1...10)
    var columns = Int.random(in: 1...10)
    var mockObject: Map?
    let randomCount = Int.random(in: 1...50)
    let decoder = JSONDecoder()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        url = FileStorage.getUrl(fileName)
        mockObject = Map(rows: rows, columns: columns, startPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)), goalPoint: CGPoint(x: Int.random(in: 0..<rows), y: Int.random(in: 0..<columns)))
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
        
        if !urls.isEmpty {
            do {
                for url in urls {
                    try FileManager.default.removeItem(at: url)
                }
            }
            catch { print(String(describing: error)) }
        }
    }

    func test_FileStorage_getUrl_shouldReturnUrl() {
        guard let url = url else { return }
        XCTAssertNotNil(url)
        XCTAssertEqual(url.lastPathComponent, fileName)
        XCTAssertEqual(documentDirectory.appending(component: fileName), url)
    }

    func test_FileStorage_store_shouldCreateFileAndRecordData() {
        guard let url = url else { return }
        FileStorage.store(mockObject, as: fileName)
        
        do {
            XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
            let data = try Data(contentsOf: url)
            let map = try decoder.decode(type(of: mockObject), from: data)
            XCTAssertEqual(map, mockObject)
        } catch {
            XCTFail()
        }
    }
    
    func test_FileStorage_retrieve_shouldReturnObject() {
        FileStorage.store(mockObject, as: fileName)
        let object: Map? = FileStorage.retrieve(fileName)
        XCTAssertEqual(object, mockObject)
    }
    
    func test_FileStorage_retrieve_shouldReturnPathDoesNotExist() {
        guard let url = url else { return }
        let object: Map? = FileStorage.retrieve(fileName)
        XCTAssertFalse(FileManager.default.fileExists(atPath: url.path))
        XCTAssertNil(object)
    }
    
    func test_FileStorage_retrieve_shouldReturnNoDataAtExistingPath() {
        guard let url = url else { return }
        FileStorage.store("", as: fileName)
        let object: Map? = FileStorage.retrieve(fileName)
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
        XCTAssertNil(object)
    }
    
    func test_FileStorage_read_shouldReturnListOfExistingPaths() {
        var files: [String] = []
        for _ in 1...randomCount {
            let fileName = UUID().uuidString
            let url = FileStorage.getUrl(fileName)
            FileStorage.store(mockObject, as: fileName)
            files.append(url.lastPathComponent)
            urls.append(url)
        }
        
        let readResults = FileStorage.read()
        XCTAssertNotNil(try FileManager.default.contentsOfDirectory(atPath: documentDirectory.path))
        XCTAssertEqual(files.count, readResults?.count)
        XCTAssertEqual(files.sorted(), readResults?.sorted())
    }
    
    func test_FileStorage_remove_shouldRemoveExistingFile() {
        guard let url = url else { return }
        FileStorage.store(mockObject, as: fileName)
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
        FileStorage.remove(fileName)
        XCTAssertFalse(FileManager.default.fileExists(atPath: url.path))
    }
    
    func test_FileStorage_clear_shouldClearDirectory() {
        for _ in 1...randomCount {
            let fileName = UUID().uuidString
            FileStorage.store(mockObject, as: fileName)
        }
        XCTAssertTrue(FileStorage.read()?.count == randomCount)
        FileStorage.clear()
        XCTAssertTrue(FileStorage.read()?.count == 0)
    }
}
