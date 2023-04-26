//
//  Maze.swift
//  MazeA*
//
//  Created by Imen Ksouri on 15/04/2023.
//

import Foundation

@MainActor
final class Maze: ObservableObject {
    @Published var map: Map
    let algorithm = AStarAlgorithm()
    @Published var solution: [CGPoint]?
    @Published var isSolving: Bool = false
    @Published var isSolved: Bool = false
    
    init(map: Map) {
        self.map = map
        self.algorithm.maze = self
    }
    
    func getSolution() async {
        isSolving = true
        solution = algorithm.shortestPath(from: map.startPoint, to: map.goalPoint)
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
        let solution = algorithm.shortestPath(from: map.startPoint, to: map.goalPoint)
        if let solution = solution {
            var path = [String]()
            for point in solution {
                path.append("(\(Int(point.x) + 1), \(Int(point.y) + 1))")
            }
            return path.joined(separator: ", ")
        }
        return "There is no solution to this maze"
    }
    
    func createMazeWith(rows: Int, columns: Int, startPoint: CGPoint, goalPoint: CGPoint) {
        self.map = Map(rows: rows, columns: columns, startPoint: startPoint, goalPoint: goalPoint)
        self.algorithm.maze = self

        setStartPoint(atRow: Int(startPoint.x), column: Int(startPoint.y))
        removeWall(atRow: Int(startPoint.x), column: Int(startPoint.y))
        setGoalPoint(atRow: Int(goalPoint.x), column: Int(goalPoint.y))
        removeWall(atRow: Int(goalPoint.x), column: Int(goalPoint.y))
    }
    
    func loadMaze(_ data: String) {
        guard let map: Map = FileStorage.retrieve(data) else {
            return
        }
        self.map = map
    }
}

extension Maze {
    func setStartPoint(atRow row: Int, column: Int) {
        map.cells[row][column].isStartPoint = true
        map.cells[row][column].isWall = false
    }
    
    func isStartPoint(atRow row: Int, column: Int) -> Bool {
        map.cells[row][column].isStartPoint
    }
    
    
    func setGoalPoint(atRow row: Int, column: Int) {
        map.cells[row][column].isGoalPoint = true
        map.cells[row][column].isWall = false
    }
    
    func isGoalPoint(atRow row: Int, column: Int) -> Bool {
        map.cells[row][column].isGoalPoint
    }
}

extension Maze {
    func setWall(atRow row: Int, column: Int) {
        map.cells[row][column].isWall = true
    }
    
    func isWall(atRow row: Int, column: Int) -> Bool {
        map.cells[row][column].isWall
    }
    
    func removeWall(atRow row: Int, column: Int) {
        map.cells[row][column].isWall = false
    }
}

extension Maze {
    func setVisited(atRow row: Int, column: Int) {
        map.cells[row][column].isVisited = true
    }
    
    func resetVisited(atRow row: Int, column: Int) {
        map.cells[row][column].isVisited = false
    }
}

extension Maze {
    // Adjacent cells for a given cell
    func adjacentTopCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = map.cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.x > 0 {
                return CGPoint(x: coordinate.x-1, y: coordinate.y)
            }
        }
        return nil
    }
    
    func adjacentLeftCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = map.cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.y > 0 {
                return CGPoint(x: coordinate.x, y: coordinate.y-1)
            }
        }
        return nil
    }
    
    func adjacentBottomCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = map.cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.x < CGFloat(map.rows-1) {
                return CGPoint(x: coordinate.x+1, y: coordinate.y)
            }
        }
        return nil
    }
    
    func adjacentRightCellForCell(atCoordinate: CGPoint) -> CGPoint? {
        if let coordinate = map.cells[Int(atCoordinate.x)][Int(atCoordinate.y)].coordinate {
            if coordinate.y < CGFloat(map.columns-1) {
                return CGPoint(x: coordinate.x, y: coordinate.y+1)
            }
        }
        return nil
    }
}

extension Maze {
    // Temporary maze for customization process
    func customizeMazeWith(map: Map?, rows: Int, columns: Int, startPoint: CGPoint?, goalPoint: CGPoint?) -> Maze {
        var maze: Maze
        
        if let map = map {
            maze = Maze(map: map)
        } else {
            maze = Maze(map: Map(rows: rows, columns: columns, startPoint: CGPoint(x: 0, y: 0), goalPoint: CGPoint(x: 0, y: 0)))
            
            if let startPoint = startPoint {
                maze.map.startPoint = startPoint
                maze.map.cells[Int(startPoint.x)][Int(startPoint.y)].isStartPoint = true
            }
            
            if let goalPoint = goalPoint {
                maze.map.goalPoint = goalPoint
                maze.map.cells[Int(goalPoint.x)][Int(goalPoint.y)].isGoalPoint = true
            }
        }
        
        return maze
    }
}
