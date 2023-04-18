//
//  MazeCell.swift
//  MazeA*
//
//  Created by Imen Ksouri on 14/04/2023.
//

import Foundation
import SwiftUI

let cellSize = CGSize(width: 30, height: 30)

struct MazeCell: Identifiable, Equatable {
    static func == (lhs: MazeCell, rhs: MazeCell) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    var isStartPoint: Bool = false
    var isGoalPoint: Bool = false
    var isWall: Bool = true
    var isVisited: Bool = false
    var color: Color {
        isStartPoint || isGoalPoint ? Color.blue
        : isVisited ? Color.green
        : isWall ? Color("LightGray")
        : Color("Dark")
    }
    var coordinate: CGPoint?
    var size = cellSize
}
