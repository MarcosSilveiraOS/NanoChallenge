//
//  FileController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 21/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

struct FileController {

    let manager = FileManager.default
    let mainPath  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func constructPath(named: String, from path: String? = nil) -> URL {
        let contentPath = mainPath
        if let path = path {
            return contentPath.appendingPathComponent(path).appendingPathComponent(named)
        } else {
            return contentPath.appendingPathComponent(named)
        }
    }
    
    @discardableResult
    func createFile(with data: Data, name: String) -> Bool {
        let contentPath = constructPath(named: name)
        manager.createFile(atPath: contentPath.path, contents: data, attributes: nil)
        return manager.fileExists(atPath: contentPath.path)
    }

    @discardableResult
    func updateFile(at path: String, data: Data) -> Bool {
        let contentPath = constructPath(named: path)
        do {
            try data.write(to: contentPath)
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    func retrieveFile(at path: String) -> Data? {
        let contentPath = constructPath(named: path)
        let data = try? Data(contentsOf: contentPath)
        return data
    }
}
