//
//  chat-socket-swift.swift
//  chat-socket-swift
//
//  Created by Valkyrie on 09/08/22.
//

import Foundation
import SocketIO

// Wrapper for SocketIO
public class ChatSocket {
    //MARK: - Properties
    // public properties
    public var urlString : String? {
        didSet {
            if let urlString = urlString {
                setupServer(urlString: urlString)
            }
        }
    }
    public var isLoggingEnabled : Bool = false {
        didSet {
            Log.toggleLogging(isLoggingEnabled)
        }
    }
    
    //Events
    public var messageSendEvent : String = ""
    public var messageReceiveEvent : String = ""
    
    //private properties
    private var socketManager : SocketManager?
    private var socket : SocketIOClient?
    
    //MARK: - Singleton
    public static let sharedInstance = ChatSocket()
    
    private init() {
        
    }
    
    //MARK: - Private methods
    private func setupServer(urlString: String) {
        guard let serverUrl = URL(string: urlString) else {
            // handle invalid url
            return
        }
        
        let socketConfiguration = SocketIOClientConfiguration(arrayLiteral: SocketIOClientConfiguration.Element.log(isLoggingEnabled))
        
        socketManager = SocketManager(socketURL: serverUrl, config: socketConfiguration)
        
        if let socketManager = socketManager {
            self.socket = socketManager.defaultSocket
        }
        
    }
    
    //MARK: - Public Methods
    // Connect
    public func connect(_ completionHandler : @escaping ((String) -> Void)) {
        if let socket = socket {
            socket.on(clientEvent: .connect) { response, ack in
                Log.info(type: .notice, title: Constants.StringConstants.connectionRequest, message: Constants.StringConstants.connectionSuccessfull)
                Log.info(type: .info,title: Constants.StringConstants.startedListeningForEvent, message: self.messageReceiveEvent)
                socket.on(self.messageReceiveEvent) { data, ack in
                    guard let response = data[0] as? String else {return}
                    Log.info(type: .info, title: Constants.StringConstants.serverResponse, message: response)
                    completionHandler(response)
                }
            }
            socket.connect()
        }
    }
    
    // Disconnect
    public func disconnect() {
        if let socket = socket {
            socket.on(clientEvent: .disconnect) { response, ack in
                Log.info(type: .notice, title: Constants.StringConstants.disconnectionRequest, message: Constants.StringConstants.disconnectionSuccessfull)
            }
            socket.disconnect()
        }
    }
    
    // send message
    public func sendMessage(_ message: String) {
        if let socket = socket {
            Log.info(type: .info, title: Constants.StringConstants.sendingMessage, message: message)
            socket.emit(messageSendEvent, message)
        }
    }
    
}
