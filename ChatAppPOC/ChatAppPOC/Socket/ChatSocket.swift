//
//  ChatSocket.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 09/08/22.
//

import Foundation
import SocketIO

// Wrapper for SocketIO
class ChatSocket {
    //MARK: - Properties
    // public properties
    var urlString : String? {
        didSet {
            if let urlString = urlString {
                setupServer(urlString: urlString)
            }
        }
    }
    var isLoggingEnabled : Bool = false {
        didSet {
            Log.toggleLogging(isLoggingEnabled)
        }
    }
    var messageSendEvent : String = ""
    var messageReceiveEvent : String = ""
    var logoutEvent : String = ""
    var chatSocketErrors : ((Error) -> ())?
    
    
    //private properties
    private var socketManager : SocketManager?
    private var socket : SocketIOClient?
    
    //MARK: - Singleton
    static let sharedInstance = ChatSocket()
    
    private init() {
        
    }
    
    //MARK: - Private methods
    private func setupServer(urlString: String) {
        guard let serverUrl = URL(string: urlString) else {
            Log.info(type: .error, message: Constants.StringConstants.invalidUrl)
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
    public func connect(onMessageReceiveEvent completionHandler : @escaping ((String, Error?) -> Void)) {
        if let socket = socket {
            socket.on(clientEvent: .connect) { response, ack in
                Log.info(type: .notice, title: Constants.StringConstants.connectionRequest, message: Constants.StringConstants.connectionSuccessfull)
                Log.info(type: .info,title: Constants.StringConstants.startedListeningForEvent, message: self.messageReceiveEvent)
                socket.on(self.messageReceiveEvent) { data, ack in
                    //Event hit for delivered
                    guard let response = data[0] as? String else {return}
                    Log.info(type: .info, title: Constants.StringConstants.serverResponse, message: response)
                    completionHandler(response, nil)
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
            Log.info(type: .info, title: Constants.StringConstants.sendingTextMessage, message: message)
            socket.emit(messageSendEvent, message)
        }
    }
    
    public func sendMultimediaMessage(_ imageUrl: String) {
        if let socket = socket {
            Log.info(type: .info, title: Constants.StringConstants.sendingMultimediaMessage, message: imageUrl)
            socket.emit(messageSendEvent, imageUrl)
        }
    }
    
    //TODO: - Implement this stubs
    //Message seen
    public func messageSeen() {}
    
    //Message Delivered
    public func messageDelivered() {}
}
