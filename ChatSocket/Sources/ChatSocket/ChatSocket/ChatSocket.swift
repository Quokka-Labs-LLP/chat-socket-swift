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
    public func connect() {
        if let socket = socket {
            socket.on(clientEvent: .connect) { response, ack in
                print("Connected successfully")
                // start listening
                print("Started Listening")
                socket.on(self.messageReceiveEvent) { data, ack in
                    guard let response = data[0] as? String else {return}
                    print("Server response : \(response)")
                    
                }
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
    public func sendMessage(_ message: String) {
        if let socket = socket {
            //let payloadMessage : SocketData = ["message" : message]
            socket.emit(messageSendEvent, message)
        }
    }
    
}
