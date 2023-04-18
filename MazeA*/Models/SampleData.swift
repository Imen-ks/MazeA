//
//  SampleData.swift
//  MazeA*
//
//  Created by Imen Ksouri on 16/04/2023.
//

import Foundation

#if DEBUG
class Cell {    
    static func createSampleData() -> [[MazeCell]] {
        var sampleData: [[MazeCell]] = Array(repeating: [MazeCell] (repeating: MazeCell(), count: 4), count: 2)
        sampleData[0][0].isStartPoint = true
        sampleData[0][0].coordinate = CGPoint(x: 0, y: 0) // -> color of cell should be blue
        sampleData[0][1].isWall = false
        sampleData[0][1].isVisited = true
        sampleData[0][1].coordinate = CGPoint(x: 0, y: 1) // -> color of cell should be green
        sampleData[0][2].isWall = false
        sampleData[0][2].isVisited = true
        sampleData[0][2].coordinate = CGPoint(x: 0, y: 2) // -> color of cell should be green
        sampleData[0][3].coordinate = CGPoint(x: 0, y: 3) // -> color of cell should be gray
        sampleData[1][0].isWall = false
        sampleData[1][0].coordinate = CGPoint(x: 1, y: 0) // -> color of cell should be gray
        sampleData[1][1].coordinate = CGPoint(x: 1, y: 1) // -> color of cell should be black
        sampleData[1][2].isWall = false
        sampleData[1][2].isVisited = true
        sampleData[1][2].coordinate = CGPoint(x: 1, y: 2) // -> color of cell should be green
        sampleData[1][3].isGoalPoint = true
        sampleData[1][3].coordinate = CGPoint(x: 1, y: 3) // -> color of cell should be blue
        return sampleData
    }
}

extension Maze {
    static func createSampleData() -> Maze {
        let sampleMaze = Maze(rows: 16, columns: 9, startPoint: CGPoint(x: 2, y: 2), goalPoint: CGPoint(x: 14, y: 8))
        sampleMaze.cells = Array(repeating: [MazeCell] (repeating: MazeCell(), count: 9), count: 16)
        for i in 0..<16 {
            for j in 0..<9 {
                sampleMaze.cells[i][j].coordinate = CGPoint(x: i, y: j)
            }
        }
        sampleMaze.algorithm.maze = sampleMaze
        sampleMaze.setStartPoint(atRow: 2, column: 2)
        sampleMaze.removeWall(atRow: 2, column: 2)
        sampleMaze.setGoalPoint(atRow: 14, column: 8)
        sampleMaze.removeWall(atRow: 14, column: 8)
        sampleMaze.removeWall(atRow: 1, column: 2)
        sampleMaze.removeWall(atRow: 1, column: 3)
        sampleMaze.removeWall(atRow: 1, column: 4)
        sampleMaze.removeWall(atRow: 1, column: 5)
        sampleMaze.removeWall(atRow: 1, column: 6)
        sampleMaze.removeWall(atRow: 1, column: 7)
        sampleMaze.removeWall(atRow: 2, column: 4)
        sampleMaze.removeWall(atRow: 2, column: 7)
        sampleMaze.removeWall(atRow: 3, column: 4)
        sampleMaze.removeWall(atRow: 3, column: 5)
        sampleMaze.removeWall(atRow: 3, column: 6)
        sampleMaze.removeWall(atRow: 3, column: 7)
        sampleMaze.removeWall(atRow: 4, column: 2)
        sampleMaze.removeWall(atRow: 4, column: 3)
        sampleMaze.removeWall(atRow: 4, column: 4)
        sampleMaze.removeWall(atRow: 4, column: 6)
        sampleMaze.removeWall(atRow: 5, column: 1)
        sampleMaze.removeWall(atRow: 5, column: 2)
        sampleMaze.removeWall(atRow: 5, column: 6)
        sampleMaze.removeWall(atRow: 6, column: 2)
        sampleMaze.removeWall(atRow: 6, column: 3)
        sampleMaze.removeWall(atRow: 6, column: 4)
        sampleMaze.removeWall(atRow: 6, column: 6)
        sampleMaze.removeWall(atRow: 7, column: 3)
        sampleMaze.removeWall(atRow: 7, column: 6)
        sampleMaze.removeWall(atRow: 8, column: 1)
        sampleMaze.removeWall(atRow: 8, column: 2)
        sampleMaze.removeWall(atRow: 8, column: 3)
        sampleMaze.removeWall(atRow: 8, column: 6)
        sampleMaze.removeWall(atRow: 9, column: 2)
        sampleMaze.removeWall(atRow: 9, column: 6)
        sampleMaze.removeWall(atRow: 9, column: 7)
        sampleMaze.removeWall(atRow: 10, column: 2)
        sampleMaze.removeWall(atRow: 10, column: 3)
        sampleMaze.removeWall(atRow: 10, column: 4)
        sampleMaze.removeWall(atRow: 10, column: 7)
        sampleMaze.removeWall(atRow: 11, column: 4)
        sampleMaze.removeWall(atRow: 11, column: 5)
        sampleMaze.removeWall(atRow: 11, column: 7)
        sampleMaze.removeWall(atRow: 12, column: 2)
        sampleMaze.removeWall(atRow: 12, column: 3)
        sampleMaze.removeWall(atRow: 12, column: 4)
        sampleMaze.removeWall(atRow: 12, column: 5)
        sampleMaze.removeWall(atRow: 12, column: 7)
        sampleMaze.removeWall(atRow: 12, column: 7)
        sampleMaze.removeWall(atRow: 13, column: 3)
        sampleMaze.removeWall(atRow: 13, column: 5)
        sampleMaze.removeWall(atRow: 13, column: 6)
        sampleMaze.removeWall(atRow: 13, column: 7)
        sampleMaze.removeWall(atRow: 14, column: 1)
        sampleMaze.removeWall(atRow: 14, column: 2)
        sampleMaze.removeWall(atRow: 14, column: 3)
        sampleMaze.removeWall(atRow: 14, column: 5)
        sampleMaze.removeWall(atRow: 14, column: 7)
        return sampleMaze
    }
}
#endif
