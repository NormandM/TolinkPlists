//
//  Plist.swift
//  ToLinkPlists
//
//  Created by Normand Martin on 16-05-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
struct Plist {
    enum PlistError: ErrorType {
        case FileNotWritten
        case FileDoesNotExist
    }
    let name:String
    var sourcePath:String? {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist") else { return .None }
        return path
        
    }
    var destPath:String? {
        guard sourcePath != .None else { return .None }
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        print(dir)
        return (dir as NSString).stringByAppendingPathComponent("\(name).plist")
            
        
        
    }
    init?(name:String) {
        self.name = name
        let fileManager = NSFileManager.defaultManager()
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExistsAtPath(source) else { return nil }
        if !fileManager.fileExistsAtPath(destination) {
            do {
                try fileManager.copyItemAtPath(source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    func getValuesInPlistFile() -> NSArray?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let arr = NSArray(contentsOfFile: destPath!) else { return .None }
            return arr
        } else {
            return .None
        }
    }
    func getMutablePlistFile() -> NSMutableArray?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let arr = NSMutableArray(contentsOfFile: destPath!) else { return .None }
            return arr
        } else {
            return .None
        }
    }
    func addValuesToPlistFile(array:NSArray) throws {
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            if !array.writeToFile(destPath!, atomically: false) {
                print("File not written successfully")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }
}
