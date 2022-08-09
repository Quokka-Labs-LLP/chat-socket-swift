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
    public var isLoggingEnabled : Bool = false
    
    //Events
    public var messageSendEvent : String = "NodeJS Server Port"
    public var messageReceiveEvent : String = "iOS Client Port"
    
    //private properties
    private var socketManager : SocketManager?
    private var socket : SocketIOClient?
    
    //MARK: - Singleton
    public static let sharedInstance = ChatSocket()
    
    public init() {
        
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
    public func connect() {
        if let socket = socket {
            socket.on(clientEvent: .connect) { response, ack in
                print("Connected successfully")
            }
            
            socket.connect()
        }
    }
    
    // Disconnect
    public func disconnect() {
        if let socket = socket {
            socket.on(clientEvent: .disconnect) { response, ack in
                print("Disconnected successfully")
            }
            
            socket.disconnect()
        }
    }
    
    // send message
    public func sendMessage(_ message: String, _ completionHandler : @escaping ((String) -> Void)) {
        if let socket = socket {
            let payloadMessage : SocketData = ["message" : message]
            // start listening
            socket.on(messageReceiveEvent) { data, ack in
                guard let response = data[0] as? [String: String] else {return}
                guard let message = response["msg"] else {return}
                
                print("[INFO]: server response:", message)
                completionHandler(message)
            }
            
            socket.emit(messageSendEvent, payloadMessage)
        }
    }
    
}
