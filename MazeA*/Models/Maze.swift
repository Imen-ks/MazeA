//
//  Maze.swift
//  MazeA*
//
//  Created by Imen Ksouri on 15/04/2023.
//

import Foundation
import SwiftUI

@MainActor
final class Maze: ObservableObject {
    let rows: Int
    let columns: Int
    var startPoint: CGPoint
    var goalPoint: CGPoint
    @Published var cells: [[MazeCell]]
    let algorithm = AStarAlgorithm()
    @Published var solution: [CGPoint]?
    @Published var isSolving: Bool = false
    @Published var isSolved: Bool = false
    
    init(rows: Int, columns: Int, startPoint: CGPoint, goalPoint: CGPoint) {
        self.rows = rows
        self.columns = columns
        self.startPoint = startPoint
        self.goalPoint = goalPoint
        self.cells = Array(repeating: [MazeCell] (repeating: MazeCell(), count: columns), count: rows)
        self.algorithm.maze = self
        
        for i in 0..<rows {
            for j in 0..<columns {
                cells[i][j].coordinate = CGPoint(x: i, y: j)
            }
        }
        setStartPoint(atRow: Int(startPoint.x), column: Int(startPoint.y))
        removeWall(atRow: Int(startPoint.x), column: Int(startPoint.y))
        setGoalPoint(atRow: Int(goalPoint.x), column: Int(goalPoint.y))
        removeWall(atRow: Int(goalPoint.x), column: Int(goalPoint.y))
    }
    
    func getSolution() async {
        isSolving = true
        solution = algorithm.shortestPath(from: startPoint, to: goalPoint)
        if let solution = solution {
            for point in solution {
                setVisited(atRow: Int(point.x), column: Int(point.y))
                do {
                    try await Task.sleep(nanoseconds: 200_000_000)
                } catch {
                    print(error)
                }
            }
        }
        isSolving = false
        isSolved = true
    }
    
    func reset() {
        if let solution = solution {
            for point in solution {
                if point != startPoint && point != goalPoint {
                    resetVisited(atRow: Int(point.x), column: Int(point.y))
                }
            }
            self.solution = []
        }
        isSolved = false
    }
}

extension Maze {
    func setStartPoint(atRow row: Int, column: Int) {
        cells[row][column].isStartPoint = true
    }
    
    func removeStartPoint(atRow row: Int, column: Int) {
        cells[row][column].isStartPoint = false
    }
    
    func setGoalPoint(atRow row: Int, column: Int) {
        cells[row][column].isGoalPoint = true
    }
    
    func removeGoalPoint(atRow row: Int, column: Int) {
        cells[row][column].isGoalPoint = false
    }
}

extension Maze {
    func setWall(atRow row: Int, column: Int) {
        if row != Int(startPoint.x) && column != Int(startPoint.y) {
            cells[row][column].isWall = true
        } else if row != Int(goalPoint.x) && column != Int(goalPoint.y) {
            cells[row][column].isWall = true
        }
        
    }
    
    func isWall(atRow row: Int, column: Int) -> Bool {
        cells[row][column].isWall
    }
    
    func removeWall(atRow row: Int, column: Int) {
        cells[row][column].isWall = false
    }
}

extension Maze {
    func setVisited(atRow row: Int, column: Int) {
        cells[row][column].isVisited = true
    }
    
    func resetVisited(atRow row: Int, column: Int) {
        cells[row][column].isVisited = false
    }
}

extension Maze {
    // Adjacent cells for a given cell
    func adjacentTopCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.x > 0 {
                return CGPoint(x: coordinate.x-1, y: coordinate.y)
            }
        }
        return nil
    }
    
    func adjacentLeftCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.y > 0 {
                return CGPoint(x: coordinate.x, y: coordinate.y-1)
            }
        }
        return nil
    }
    
    func adjacentBottomCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.x < CGFloat(rows-1) {
                return CGPoint(x: coordinate.x+1, y: coordinate.y)
            }
        }
        return nil
    }
    
    func adjacentRightCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.y < CGFloat(columns-1) {
                return CGPoint(x: coordinate.x, y: coordinate.y+1)
            }
        }
        return nil
    }
}
