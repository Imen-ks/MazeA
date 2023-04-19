//
//  MazeDescriptionView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 19/04/2023.
//

import SwiftUI

struct MazeDescriptionView: View {
    @EnvironmentObject var maze: Maze
    @Binding var showDescription: Bool
    
    var numberOfBoxes: Int {
        maze.cells.flatMap { $0 }.count
    }
    
    var numberOfWalls: Int {
        maze.cells.flatMap { $0 }
            .filter { maze.isWall(atRow: Int($0.coordinate!.x), column: Int($0.coordinate!.y)) }.count
    }
    
    var startPoint: MazeCell {
        maze.cells.flatMap { $0 }
            .filter { maze.isStartPoint(atRow: Int($0.coordinate!.x), column: Int($0.coordinate!.y)) }
            .map { $0 }[0]
    }
    
    var goalPoint: MazeCell {
        maze.cells.flatMap { $0 }
            .filter { maze.isGoalPoint(atRow: Int($0.coordinate!.x), column: Int($0.coordinate!.y)) }
            .map { $0 }[0]
    }
    
    var solutionPath: String {
        maze.displaySolution()
    }
    
    var infos: [String: String] {
        [
            "1Number of boxes": String(describing: numberOfBoxes),
            "2Number of walls": String(describing: numberOfWalls),
            "3Start coordinates": String(describing: startPoint.description),
            "4Goal coordinates": String(describing: goalPoint.description)
        ]
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                Color.indigo
                ScrollView {
                    Section(header: Text("MAZE DESCRIPTION").font(.title2).bold()) {
                        ForEach(infos.sorted(by: <), id: \.key) { label, value in
                            HStack{
                                Text(getNewLabel(from: label))
                                Spacer()
                                Text(value)
                            }
                            Divider()
                                .overlay(Color.white)
                        }
                    }
                    .padding(.top)
                    
                    Section(header: Text("SOLUTION PATH")
                                    .foregroundColor(.indigo)
                                    .padding(8)
                                    .font(.title3)
                                    .bold()
                                    .background(.white)
                                    .cornerRadius(16)
                    ) {
                        Text(solutionPath)
                            .font(.title)
                            .bold()
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .padding()
            }
            .foregroundColor(.white)
            .ignoresSafeArea(.container, edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showDescription = false
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .padding(.top, 10)
                    }
                }
            }
        }
    }
    func getNewLabel(from label: String) -> String {
        var label = label
        label.remove(at: label.startIndex)
        return label
    }
}

struct MazeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        MazeDescriptionView(showDescription: .constant(true))
            .environmentObject(Maze.createSampleData())
    }
}
