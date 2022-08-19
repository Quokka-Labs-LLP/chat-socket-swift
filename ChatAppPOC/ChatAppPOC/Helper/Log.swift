//
//  Log.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 10/08/22.
//

import Foundation


public class Log {
    
    //MARK: - properties
    enum LogType : String {
        case notice     = "[NOTICE]:"
        case info       = "[INFO]:"
        case warning    = "[WARNING]:"
        case error      = "[ERROR]:"
    }
    
    // change this value to false if you want to disable logging throughout the app.
    private static var debuggingEnabled : Bool = true
    
    //MARK: - Methods
    class func info(type: LogType, title: String? = nil, message: String) {
        
        if debuggingEnabled {
            if let title = title {
                NSLog("\(type.rawValue) \"\(title)\" >>> \(message).")
            } else {
                NSLog("\(type.rawValue) \(message).")
            }
        }
    }
    
    class func toggleLogging(_ isEnabled: Bool) {
        self.debuggingEnabled = isEnabled
    }
}

