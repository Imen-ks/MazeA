//
//  MazeA_App.swift
//  MazeA*
//
//  Created by Imen Ksouri on 14/04/2023.
//

import SwiftUI

extension UserDefaults {
    enum Keys: String {
        case appBundle
        case fileSystem
    }
}

@main
struct MazeA_App: App {
    @AppStorage(UserDefaults.Keys.appBundle.rawValue) private var bundle: String = "MapSampleData"
    @AppStorage(UserDefaults.Keys.fileSystem.rawValue) private var fileName: String?
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environmentObject(Maze(map: Map(bundle: bundle, fileName: fileName)))
        }
    }
}
