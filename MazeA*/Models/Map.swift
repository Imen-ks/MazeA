//
//  Map.swift
//  MazeA*
//
//  Created by Imen Ksouri on 25/04/2023.
//

import Foundation

struct Map: Identifiable, Codable {
    var id = UUID()
    var rows: Int
    var columns: Int
    var startPoint: CGPoint
    var goalPoint: CGPoint
    var cells: [[MazeCell]]
    
    init(bundle: String? = nil, fileName: String? = nil) {
        self.rows = Map.loadJson(fromAppBundle: bundle, fromFileSystem: fileName).rows
        self.columns = Map.loadJson(fromAppBundle: bundle, fromFileSystem: fileName).columns
        self.startPoint = Map.loadJson(fromAppBundle: bundle, fromFileSystem: fileName).startPoint
        self.goalPoint = Map.loadJson(fromAppBundle: bundle, fromFileSystem: fileName).goalPoint
        self.cells = Map.loadJson(fromAppBundle: bundle, fromFileSystem: fileName).cells
    }
    
    init(rows: Int, columns: Int, startPoint: CGPoint, goalPoint: CGPoint) {
        self.rows = rows
        self.columns = columns
        self.startPoint = startPoint
        self.goalPoint = goalPoint
        self.cells = Array(repeating: [MazeCell] (repeating: MazeCell(), count: columns), count: rows)
        
        for i in 0..<rows {
            for j in 0..<columns {
                self.cells[i][j].coordinate = CGPoint(x: i, y: j)
            }
        }
    }
}

extension Map {
    static func loadJson(bundle: Bundle = Bundle.main, fromAppBundle urlString: String? = nil, fromFileSystem fileName: String? = nil) -> Map {
        var url: URL
        if let fileName = fileName {
            let checkUrl = FileStorage.getUrl(fileName)
            if FileManager.default.fileExists(atPath: checkUrl.path) {
                url = checkUrl
            } else {
                url = bundle.url(forResource: urlString, withExtension: "json")!
            }
        } else {
            url = bundle.url(forResource: urlString, withExtension: "json")!
        }
                
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let map = try decoder.decode(Map.self, from: data)
            return map
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension Map {
    static var sampleData = Map(bundle: "MapSampleData")
}

extension Map: Comparable {
    static func < (lhs: Map, rhs: Map) -> Bool {
        return lhs.id.uuidString < rhs.id.uuidString
     }
}
