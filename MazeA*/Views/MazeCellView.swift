//
//  MazeCellView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 15/04/2023.
//

import SwiftUI

struct MazeCellView: View {
    var cell: MazeCell
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
        cell.isStartPoint || cell.isGoalPoint ? Color(uiColor: .systemGray3)
        : cell.isVisited ? Color.green
        : cell.isWall ? Color(uiColor: .systemGray3)
        : Color.black
    }
    
    var image: String {
        cell.isStartPoint ? "start"
        : cell.isGoalPoint ? "goal"
        : cell.isVisited ? "footprint"
        : cell.isWall ? "wall"
        : "path"
    }

    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .background(color)
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
        .padding()
    }
}
