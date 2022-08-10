//
//  Log.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 10/08/22.
//

import Foundation


class Log {
    
    enum LogType : String {
        case notice     = "[NOTICE]:"
        case info       = "[INFO]:"
        case warning    = "[WARNING]:"
        case error      = "[ERROR]:"
    }
    
    // change this value if you want to disable logging throughout the app.
    private static let debuggingEnabled : Bool = true
    
    class func info(type: LogType, title: String? = nil, message: String) {
        
        if debuggingEnabled {
            if let title = title {
                print("\(type.rawValue) \"\(title)\" >>> \(message).")
            } else {
                print("\(type.rawValue) \(message).")
            }
        }
    }
}
