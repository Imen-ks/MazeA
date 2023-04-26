//
//  MazeCell.swift
//  MazeA*
//
//  Created by Imen Ksouri on 14/04/2023.
//

import Foundation

let cellSize = CGSize(width: 30, height: 30)

struct MazeCell: Identifiable, Equatable, Codable {
    static func == (lhs: MazeCell, rhs: MazeCell) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var isStartPoint: Bool = false
    var isGoalPoint: Bool = false
    var isWall: Bool = true
    var isVisited: Bool = false
    var coordinate: CGPoint?
    var size = cellSize
}

extension MazeCell: CustomStringConvertible {
    var description: String {
        if let coordinate = coordinate {
            return "(\(Int(coordinate.x) + 1), \(Int(coordinate.y) + 1))"
        }
        else { return "" }
    }
}
