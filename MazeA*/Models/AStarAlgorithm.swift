//
//  AStarAlgorithm.swift
//  MazeA*
//
//  Created by Imen Ksouri on 17/04/2023.
//

import Foundation

class AStarAlgorithm {
    var maze: Maze?
    var openList: [Step] = []
    var closedList: Set<Step> = []
    
    @MainActor func shortestPath(from start: CGPoint, to end: CGPoint) -> [CGPoint]? {
        // Resetting both lists in case they're not empty at function call
        openList = []
        closedList = []
        
        // appending the start point to the openList
        openList.append(Step(coordinate: start))
        
        // starting the iteration with the starting point
        // and then choosing the step with the lowest fScore at each iteration
        while !openList.isEmpty {
            let currentStep = openList.remove(at: 0)
            closedList.insert(currentStep)
            
            // if current step equals the destination point
            // -> the iteration is stopped and the correct path is returned
            if currentStep.coordinate == end {
                return getShortestPath(currentStep: currentStep)
            }
            
            // getting all the adjacent valid points for current step and looping through them
            let adjacentPoints = validAdjacentCoordForPoint(atCoordinate: currentStep.coordinate)
            for point in adjacentPoints {
                let step = Step(coordinate: point!)
                
                // if the adjacentPoint is already in the closedList --> we continue the iteration
                if closedList.contains(step) {
                    continue
                }
                
                // if not --> we compute its cost
                // if the adjacentPoint is in the openList then we compare it to current step
                if let index = openList.firstIndex(of: step) {
                    let step = openList[index]
                    
                    // if the current step's gScore + movement score is less than the gScore of the old version of the step
                    if currentStep.gScore + unitaryMovementCost < step.gScore {
                        // we replace the step's previousStep attribute with the current step and add the movement cost
                        step.setPreviousStep(previousStep: currentStep)
                        // we remove the old version of the step from the openList
                        openList.remove(at: index)
                        // and we add the new version
                        insertStep(step: step)
                    }
                }
                // if the adjacentPoint isn't in the openList
                else {
                    // we set the step's previousStep attribute with the current step and add the movement cost
                    step.setPreviousStep(previousStep: currentStep)
                    // we compute the hScore
                    step.hScore = manhattanDistance(from: step.coordinate, to: end)
                    // and we add the new version
                    insertStep(step: step)
                }
            }
        }
        return nil
    }
    
    @MainActor func validAdjacentCoordForPoint(atCoordinate: CGPoint) -> [CGPoint?] {
        let adjacentCoords = [
            maze?.adjacentTopCellForCell(atCoordinate: atCoordinate),
            maze?.adjacentLeftCellForCell(atCoordinate: atCoordinate),
            maze?.adjacentBottomCellForCell(atCoordinate: atCoordinate),
            maze?.adjacentRightCellForCell(atCoordinate: atCoordinate)
        ]
        return adjacentCoords
            .compactMap { $0 }
            .filter ({ maze?.isWall(atRow: Int($0.x), column: Int($0.y)) == false })
    }
    
    func insertStep(step: Step) {
        // inserting the current step to openList
        openList.append(step)
        // sorting the list by ascending order of the fScore of each step
        openList.sort { $0.fScore <= $1.fScore }
    }

    func manhattanDistance(from start: CGPoint, to end: CGPoint) -> Int {
      return abs(Int(end.x - start.x)) + abs(Int(end.y - start.y))
    }
    
    func getShortestPath(currentStep: Step) -> [CGPoint] {
        var shortestPath: [CGPoint] = []
        var currentStep = currentStep
        
        // looping through the chain list of previousStep attributes to reconstruct the solution
        
        while let previousStep = currentStep.previousStep {
            shortestPath.insert(currentStep.coordinate, at: 0)
            currentStep = previousStep
        }
        return shortestPath
    }
}
