//
//  ChatSocket.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 09/08/22.
//

import Foundation
import SocketIO
import UIKit

/// Singleton - Use sharedInstance to perform desired tasks.
public class ChatSocket {
    // MARK: - Properties
    // public properties

    /// Socket url for connection
    public var urlString : String? {
        didSet {
            if let urlString = urlString {
                setupServer(urlString: urlString)
            }
        }
    }

    /// Will print debugging logs in the console if `True`
    public var isLoggingEnabled : Bool = false {
        didSet {
            Log.toggleLogging(isLoggingEnabled)
        }
    }

    /// Socket event string to publish messages on
    public var messageSendEvent : String = ""

    /// Socket event string to listen messages on
    public var messageReceiveEvent : String = ""

    /// Socket event string to deactivate socket connection
    public var logoutEvent : String = ""

    // private properties
    private var socketManager : SocketManager?
    private var socket : SocketIOClient?

    /// Assign URL and respective events before performing any tasks.
    public static let sharedInstance = ChatSocket()

    private init() {

    }

    // MARK: - Private methods
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

    // MARK: - Public Methods

    /// Connect to socket using url provided during initialization
    /// - Parameter completionHandler: Will start listening for messages as soon as socket is connected and return the response as well as error
    public func connect(onMessageReceiveEvent completionHandler : @escaping ((String, Error?) -> Void)) {
        if let socket = socket {
            socket.on(clientEvent: .connect) { response, _ in
                Log.info(type: .notice, title: Constants.StringConstants.connectionRequest, message: Constants.StringConstants.connectionSuccessfull)
                Log.info(type: .info,title: Constants.StringConstants.startedListeningForEvent, message: self.messageReceiveEvent)
                socket.on(self.messageReceiveEvent) { data, _ in
                    // Event hit for delivered
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
            socket.on(clientEvent: .disconnect) { _, _ in
                Log.info(type: .notice, title: Constants.StringConstants.disconnectionRequest, message: Constants.StringConstants.disconnectionSuccessfull)
            }
            socket.disconnect()
        }
    }

    // send message
//    public func sendMessage(_ message: String) {
//        if let socket = socket {
//            Log.info(type: .info, title: Constants.StringConstants.sendingTextMessage, message: message)
//            socket.emit(messageSendEvent, message)
//            sendDataMessage(ChatDataModel(message: message, userName: "Rachel", imageUrl: "imageUrl", timeStamp: "45:56:67:76", isMultimediaCell: false, isSender: true))
//        }
//    }

    func sendMessage(_ chatData: ChatDataModel) {
        if let socket = socket {
            Log.data(type: .info, data: chatData)
            do {
                let data = try JSONEncoder().encode(chatData)
                print(data)
                decodeData(data: data)
            } catch {
                Log.info(type: .error, message: "Something went wrong when encoding json data")
            }



            //socket.emit(messageSendEvent, Data())
        }
    }

    func decodeData(data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(ChatDataModel.self, from: data)
            print(decodedData)
        } catch {
            Log.info(type: .error, message: "Something went wrong when decoding json data")
        }
    }

    public func sendMultimediaMessage(_ imageUrl: String) {
        if let socket = socket {
            Log.info(type: .info, title: Constants.StringConstants.sendingMultimediaMessage, message: imageUrl)
            socket.emit(messageSendEvent, imageUrl)
        }
    }

//    public func getImageUrl(image: UIImage) -> String {
//
//        if let imageUrl = Network.handler.getImageUrl(image: image, imageName: "image.png") {
//
//        }
//
//
//
//        return ""
//    }

}
