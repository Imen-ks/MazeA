//
//  Step.swift
//  MazeA*
//
//  Created by Imen Ksouri on 17/04/2023.
//

import Foundation

let unitaryMovementCost = 1

class Step {
    let coordinate: CGPoint
    var previousStep: Step?
    var gScore: Int = 0 // movement cost of the path from the start to current position
    var hScore: Int = 0 // heurisitc cost of the cheapest path from current position to the goal (manhattan distance)
    var fScore: Int {
        gScore + hScore
    }
    
    init(coordinate: CGPoint) {
        self.coordinate = coordinate
    }
    
    func setPreviousStep(previousStep: Step) {
        self.previousStep = previousStep
        self.gScore = previousStep.gScore + unitaryMovementCost
    }
}

extension Step: Hashable {
    static func ==(lhs: Step, rhs: Step) -> Bool {
      return lhs.coordinate == rhs.coordinate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate.x)
        hasher.combine(coordinate.y)
    }
}

extension Step: CustomStringConvertible {
    var description: String {
        "(\(self.coordinate.x), \(self.coordinate.y))"
    }
}
