//
//  MazeCellView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 15/04/2023.
//

import SwiftUI

struct MazeCellView: View {
    @EnvironmentObject var maze: Maze
    var cell: MazeCell
    var strokeLineWidth = 2
    var action: () -> Void
    
    var startX: CGFloat {
        cell.size.height * (cell.coordinate?.y ?? 0)
    }
    var startY: CGFloat {
        cell.size.width * (cell.coordinate?.x ?? 0)
    }
    var rect: CGRect {
        CGRect(x: startX, y: startY, width: cell.size.width, height: cell.size.height)
    }
    
    var color: Color {
        cell.isStartPoint || cell.isGoalPoint ? Color.yellow
        : cell.isVisited ? Color.green
        : cell.isWall ? Color("LightGray")
        : Color("Dark")
    }
    
    var image: String {
        cell.isStartPoint ? "start"
        : cell.isGoalPoint ? "goal"
        : cell.isVisited ? "footprint"
        : cell.isWall ? "wall"
        : "path"
    }

    var body: some View {
//        let path = Path(rect)
//        path.fill(color)
//            .overlay(path.stroke(Color("Dark"), lineWidth: CGFloat(strokeLineWidth)))
//            .onTapGesture {
//                action()
//            }
        
//        Canvas { context, size in
//            context.stroke(path, with: .color(Color("Dark")), lineWidth: CGFloat(strokeLineWidth))
//            context.fill(path, with: .color(color))
//            context.draw(Image(image), in: rect)
//        }
//        .onTapGesture {
//            action()
//        }
        
        Image(image)
            .resizable()
            .scaledToFill()
            .background(color)
            .border(Color("Dark"), width: CGFloat(strokeLineWidth))
            .frame(width: cell.size.width, height: cell.size.height)
            .position(x: startX, y: startY)
            .onTapGesture {
                action()
            }
    }
}

struct MazeCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            MazeCellView(cell: Cell.createSampleData()[0][0], action: {})
            MazeCellView(cell: Cell.createSampleData()[0][1], action: {})
            MazeCellView(cell: Cell.createSampleData()[0][2], action: {})
            MazeCellView(cell: Cell.createSampleData()[0][3], action: {})
            MazeCellView(cell: Cell.createSampleData()[1][0], action: {})
            MazeCellView(cell: Cell.createSampleData()[1][1], action: {})
            MazeCellView(cell: Cell.createSampleData()[1][2], action: {})
            MazeCellView(cell: Cell.createSampleData()[1][3], action: {})
        }
//        .frame()
        .padding()
        .environmentObject(Maze.createSampleData())
    }
}
