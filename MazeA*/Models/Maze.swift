//
//  Maze.swift
//  MazeA*
//
//  Created by Imen Ksouri on 15/04/2023.
//

import Foundation

@MainActor
final class Maze: ObservableObject {
    var rows: Int
    var columns: Int
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
                resetVisited(atRow: Int(point.x), column: Int(point.y))
            }
            self.solution = nil
        }
        isSolved = false
    }
    
    func displaySolution() -> String {
        let solution = algorithm.shortestPath(from: startPoint, to: goalPoint)
        if let solution = solution {
            var path = [String]()
            for point in solution {
                path.append("(\(Int(point.x) + 1), \(Int(point.y) + 1))")
            }
            return path.joined(separator: ", ")
        }
        return "There is no solution to this maze"
    }
    
    func customizeMazeWith(rows: Int, columns: Int, startPoint: CGPoint, goalPoint: CGPoint) {
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
    
    func loadMaze() {
        // temporary logic for test purpose -  to be updated
        self.rows = 16
        self.columns = 9
        self.startPoint = CGPoint(x: 2, y: 2)
        self.goalPoint = CGPoint(x: 14, y: 8)
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
        
        removeWall(atRow: 14, column: 8)
        removeWall(atRow: 1, column: 2)
        removeWall(atRow: 1, column: 3)
        removeWall(atRow: 1, column: 4)
        removeWall(atRow: 1, column: 5)
        removeWall(atRow: 1, column: 6)
        removeWall(atRow: 1, column: 7)
        removeWall(atRow: 2, column: 4)
        removeWall(atRow: 2, column: 7)
        removeWall(atRow: 3, column: 4)
        removeWall(atRow: 3, column: 5)
        removeWall(atRow: 3, column: 6)
        removeWall(atRow: 3, column: 7)
        removeWall(atRow: 4, column: 2)
        removeWall(atRow: 4, column: 3)
        removeWall(atRow: 4, column: 4)
        removeWall(atRow: 4, column: 6)
        removeWall(atRow: 5, column: 1)
        removeWall(atRow: 5, column: 2)
        removeWall(atRow: 5, column: 6)
        removeWall(atRow: 6, column: 2)
        removeWall(atRow: 6, column: 3)
        removeWall(atRow: 6, column: 4)
        removeWall(atRow: 6, column: 6)
        removeWall(atRow: 7, column: 3)
        removeWall(atRow: 7, column: 6)
        removeWall(atRow: 8, column: 1)
        removeWall(atRow: 8, column: 2)
        removeWall(atRow: 8, column: 3)
        removeWall(atRow: 8, column: 6)
        removeWall(atRow: 9, column: 2)
        removeWall(atRow: 9, column: 6)
        removeWall(atRow: 9, column: 7)
        removeWall(atRow: 10, column: 2)
        removeWall(atRow: 10, column: 3)
        removeWall(atRow: 10, column: 4)
        removeWall(atRow: 10, column: 7)
        removeWall(atRow: 11, column: 4)
        removeWall(atRow: 11, column: 5)
        removeWall(atRow: 11, column: 7)
        removeWall(atRow: 12, column: 2)
        removeWall(atRow: 12, column: 3)
        removeWall(atRow: 12, column: 4)
        removeWall(atRow: 12, column: 5)
        removeWall(atRow: 12, column: 7)
        removeWall(atRow: 12, column: 7)
        removeWall(atRow: 13, column: 3)
        removeWall(atRow: 13, column: 5)
        removeWall(atRow: 13, column: 6)
        removeWall(atRow: 13, column: 7)
        removeWall(atRow: 14, column: 1)
        removeWall(atRow: 14, column: 2)
        removeWall(atRow: 14, column: 3)
        removeWall(atRow: 14, column: 5)
        removeWall(atRow: 14, column: 7)
    }
}

extension Maze {
    func setStartPoint(atRow row: Int, column: Int) {
        cells[row][column].isStartPoint = true
    }
    
    func isStartPoint(atRow row: Int, column: Int) -> Bool {
        cells[row][column].isStartPoint
    }
    
    func removeStartPoint(atRow row: Int, column: Int) {
        cells[row][column].isStartPoint = false
    }
    
    func setGoalPoint(atRow row: Int, column: Int) {
        cells[row][column].isGoalPoint = true
    }
    
    func isGoalPoint(atRow row: Int, column: Int) -> Bool {
        cells[row][column].isGoalPoint
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
