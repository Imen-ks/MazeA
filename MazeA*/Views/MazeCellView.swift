//
//  MazeCellView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 15/04/2023.
//

import SwiftUI

struct MazeCellView: View {
    var cell: MazeCell
    var strokeLineWidth = 5
    
    var startX: CGFloat {
        cell.size.height * (cell.coordinate?.y ?? 0)
    }
    var startY: CGFloat {
        cell.size.width * (cell.coordinate?.x ?? 0)
    }
    var rect: CGRect {
        CGRect(x: startX, y: startY, width: cell.size.width, height: cell.size.height)
    }
    
    var body: some View {
        let path = Path(rect)
        path.fill(cell.color)
            .overlay(path.stroke(Color("Dark"), lineWidth: CGFloat(strokeLineWidth)))

    }
}

struct MazeCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            MazeCellView(cell: Cell.createSampleData()[0][0])
            MazeCellView(cell: Cell.createSampleData()[0][1])
            MazeCellView(cell: Cell.createSampleData()[0][2])
            MazeCellView(cell: Cell.createSampleData()[0][3])
            MazeCellView(cell: Cell.createSampleData()[1][0])
            MazeCellView(cell: Cell.createSampleData()[1][1])
            MazeCellView(cell: Cell.createSampleData()[1][2])
            MazeCellView(cell: Cell.createSampleData()[1][3])
        }
        .padding()
    }
}
