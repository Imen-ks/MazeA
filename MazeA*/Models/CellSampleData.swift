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
#endif
