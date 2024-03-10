//
//  Logger.swift
//  Whisky
//
//  Created by Isaac Marovitz on 08/06/2023.
//

import Foundation
import os

class Log {
    
    static let shared = Log() // The singleton holder
    
    static let logsFolder = FileManager.default.urls(for: .libraryDirectory,
                                                    in: .userDomainMask)[0]
        .appendingPathComponent("Logs")
        .appendingPathComponent(Bundle.main.bundleIdentifier ?? "uno.kayros.macControl")

    let fileHandle: FileHandle
    let logger: Logger

    init?(/*bottle: Bottle?,*/ /*args: [String], environment: [String: String]?*/) {
        do {
            if !FileManager.default.fileExists(atPath: Log.logsFolder.path) {
                try FileManager.default.createDirectory(at: Log.logsFolder, withIntermediateDirectories: true)
            }

            let dateString = Date.now.ISO8601Format()
            let fileURL = Log.logsFolder
                .appendingPathComponent(dateString)
                .appendingPathExtension("log")

            try "".write(to: fileURL, atomically: true, encoding: .utf8)

            fileHandle = try FileHandle(forWritingTo: fileURL)

            if let bundleID = Bundle.main.bundleIdentifier {
                logger = Logger(subsystem: bundleID, category: "kayros")
            } else {
                throw MacControlError(stringError: "Could not get Bundle ID!", kind: .fileNotFound)
                
            }

            //write(line: Log.constructHeader(/*bottle,*/ /*args, environment*/), printLine: false)
            write(line: "Starting logger...")
        } catch {
            print("Failed to create logger: \(error)")
            return nil
        }
    }

    static func constructHeader(/*_ bottle: Bottle?,*/  /*args: [String], _ environment: [String: String]?*/) -> String {
        var header = String()

        header += "macControl Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "")\n"
        header += "Date: \(Date.now.formatted(date: .numeric, time: .standard))\n"
        header += "macOS Version: \(ProcessInfo.processInfo.operatingSystemVersionString)\n"
        /*if let bottle = bottle {
            header += "Bottle Name: \(bottle.settings.name)\n"
            header += "Wine Version: \(bottle.settings.wineVersion)\n"
            header += "Wine Binary Version: \(WineInstaller.WineBinaryVersion)\n"
            header += "Windows Version: \(bottle.settings.windowsVersion)\n"
            header += "Bottle URL: \(bottle.url.path)\n\n"
        }
         */
//        header += "Arguments: "
//        for arg in args {
//            header += "\(arg) "
//        }
//        header += "\n\n"
//
//        if let environment = environment {
//            if environment.count > 0 {
//                header += "Environment:\n"
//                header += "\(environment as AnyObject)\n\n"
//            }
//        }

        return header
    }

    func write(line: String, filelog: Bool = true, oslog: Bool = true)  {
        if oslog {
            logger.log("\(line, privacy: .public)")
        }

        if filelog {
            if let data = line.data(using: .utf8) {
                do {
                    try fileHandle.write(contentsOf: data)
                } catch {
                    print("Failed to write line to log: \"\(line)\"!")
                }
            }
        }
    }

    deinit {
        do {
            try fileHandle.close()
        } catch {
            print("Failed to close log file handle!")
        }
    }
}
