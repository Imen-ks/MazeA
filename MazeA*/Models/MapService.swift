//
//  MapService.swift
//  MazeA*
//
//  Created by Imen Ksouri on 25/04/2023.
//

import Foundation

class MapService: ObservableObject {
    @Published var maps = [String: Map]()
}

extension MapService {
    func save(map: Map) {
        FileStorage.store(map, as: "map_\(map.id)")
    }
    
    func load() {
        let mapsFile = FileStorage.read() ?? []
        maps = mapsFile.compactMap{ $0 }.reduce(into: [String: Map](), { dict, file in
            dict[file] = FileStorage.retrieve(file)
        })
    }
}
