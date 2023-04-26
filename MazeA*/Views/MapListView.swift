//
//  MapListView.swift
//  MazeA*
//
//  Created by Imen Ksouri on 26/04/2023.
//

import SwiftUI

struct MapListView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var viewModel: Maze
    @StateObject var mapService = MapService()
    @Binding var isLoadingMaze: Bool
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mapService.maps.sorted(by: <), id: \.key) { file, map in
                    NavigationLink {
                        ZStack {
                            Color.teal
                                .opacity(0.7)
                                .ignoresSafeArea(.container, edges: .bottom)
                            if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                                VStack {
                                    Button {
                                        isLoadingMaze = false
                                        viewModel.loadMaze(file)
                                        UserDefaults.standard.setValue(file, forKey: "fileSystem")
                                    } label: {
                                        Label("Select", systemImage: "hand.tap")
                                            .font(.title2)
                                    }
                                    .padding(.bottom)
                                    .buttonStyle(.borderedProminent)
                                    
                                    TemporaryMazeView(map: map, rows: .constant("\(map.rows)"), columns: .constant("\(map.columns)"), startPoint: .constant(nil), goalPoint: .constant(nil), selection: .constant(nil)) {}
                                }
                            } else {
                                HStack {
                                    TemporaryMazeView(map: map, rows: .constant("\(map.rows)"), columns: .constant("\(map.columns)"), startPoint: .constant(nil), goalPoint: .constant(nil), selection: .constant(nil)) {}
                                        .padding(.leading, 120)
                                    
                                    Button {
                                        isLoadingMaze = false
                                        viewModel.loadMaze(file)
                                    } label: {
                                        Image(systemName: "hand.tap")
                                            .font(.title2)
                                            .bold()
                                            .frame(width: 40, height: 40)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding(.leading, 120)
                                }
                            }
                        }
                    } label: {
                        MapRow(map: map)
                    }
                }
                .onDelete(perform: { offsets in
                    withAnimation {
                        delete(at: offsets)
                    }
                })
                .navigationTitle("Saved Mazes")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                mapService.load()
            }
            .onChange(of: mapService.maps, perform: { _ in
                mapService.load()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        EditButton()
                        Button {
                            showAlert = true
                        } label: {
                            Text("Clear")
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Do you really want to proceed ?"), message: Text("This action will cause the deletion of data related to all the saved mazes."), primaryButton: .destructive(Text("Delete")) {
                                FileStorage.clear()
                                mapService.maps.removeAll()
                            },
                            secondaryButton: .cancel())
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isLoadingMaze = false
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .padding(.top, 10)
                    }
                }
            }
        }
    }
    func delete(at offsets: IndexSet){
        if let ndx = offsets.first {
            let item = mapService.maps.sorted(by: >)[ndx]
            FileStorage.remove(item.key)
        }
    }
}

struct MapListView_Previews: PreviewProvider {
    static var previews: some View {
        MapListView(isLoadingMaze: .constant(true))
            .environmentObject(Maze(map: Map.sampleData))
    }
}

struct MapRow: View {
    var map: Map
    var walls: String {
        "\(map.cells.flatMap { $0 }.map { $0.isWall }.count)"
    }
    var start: String {
        "(\(Int(map.startPoint.x) + 1), \(Int(map.startPoint.y) + 1))"
    }
    var goal: String {
        "(\(Int(map.goalPoint.x) + 1), \(Int(map.goalPoint.y) + 1))"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("id: \(map.id)")
                .font(.caption)
                .bold()
                .foregroundColor(.secondary)
                .padding(.bottom, 1)
            Text("\(map.rows) rows / \(map.columns) columns")
            Text("\(walls) walls")
            Text("Start coordinates:  \(start)")
            Text("Goal coordinates:  \(goal)")
        }
    }
}
