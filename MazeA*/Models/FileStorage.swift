//
//  FileStorage.swift
//  MazeA*
//
//  Created by Imen Ksouri on 25/04/2023.
//

import Foundation

extension FileManager {
    static var documentDirectoryUrl: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

struct FileStorage {
    
    static func store<T: Encodable>(_ object: T, as fileName: String) {
        let url = FileManager.documentDirectoryUrl.appending(path: fileName, directoryHint: .notDirectory)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            print(String(describing: error))
        }
    }
    
    static func retrieve<T: Decodable>(_ fileName: String) -> T? {
        let url = FileManager.documentDirectoryUrl.appending(path: fileName, directoryHint: .notDirectory)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File at path \(url.path) does not exist")
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(T.self, from: data)
                return object
            } catch {
                print(String(describing: error))
                return nil
            }
        } else {
            print("No data at \(url.path)")
            return nil
        }
    }
    
    static func read() -> [String]? {
        let url = FileManager.documentDirectoryUrl
        do {
            return try FileManager.default.contentsOfDirectory(atPath: url.path)
        } catch {
            print(String(describing: error))
        }
        return nil
    }
    
    static func remove(_ fileName: String) {
        let url = FileManager.documentDirectoryUrl.appending(path: fileName, directoryHint: .notDirectory)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    static func clear() {
        let url = FileManager.documentDirectoryUrl
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            print(String(describing: error))
        }
    }
}
