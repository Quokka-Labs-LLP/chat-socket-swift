//
//  InputViewVM.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import SwiftUI
import SocketIO

class InboxViewVM : ObservableObject {

    // MARK: - Properties
    var socketManager : SocketManager?
    var socket : SocketIOClient?
//    var inboxCustomization : InboxViewCustomizationModel? {
//        didSet {
//            if let inboxCustomization = inboxCustomization {
//                setupCustomizations(inboxCustomization)
//            }
//        }
//    }

    var chatSocket : ChatSocket = {
        /// URL for local host ws://localhost:3000
        let chatSocket = ChatSocket.sharedInstance
//        chatSocket.urlString = "http://3.143.67.28:3000"
//        chatSocket.urlString = "ws://localhost:3000"
        chatSocket.urlString = "http://192.168.1.254:3000"
//        chatSocket.urlString = "http://192.168.1.37:3000"
        chatSocket.messageSendEvent = "newMessage"
        chatSocket.messageReceiveEvent = "newMessage"
        chatSocket.isLoggingEnabled = true
        return chatSocket
    }()

    // Published
    @Published var chatMessages : [ChatDataModel] = []

    // TODO: group all these properties using struct or enum.
    // Customization options and default values
    // TITLE VIEW
    let titleName: String
    let customFont: Font
    let titleFontColor: Color
    let titleBarBackgroundColor: Color

    // CHAT CELL
    // - Sender
    let senderShouldShowHeading: Bool
    let senderCellMessageFont: Font
    let senderCellHeadingFont: Font
    let senderCellTimeFont: Font
    let senderCellFontColor: Color
    let senderCellBackgroundColor: Color

    // - Receiver
    let receiverCellMessageFont: Font
    let receiverHeadingFont: Font
    let receiverCellTimeFont: Font
    let receiverFontCellColor: Color
    let receiverCellBackgroundColor: Color

    // CHAT TEXTFIELD VIEW
    let textFieldFont: Font
    let textFieldPlaceholderText: String
    let textFieldBackgroundColor: Color
    let textfieldAccentColor: Color
    let textFieldFontColor: Color
    let buttonColor: Color
    let mainBackground: Color

    init(inboxCustomization : InboxViewCustomizationModel?) {
        // - title view
        self.titleName = inboxCustomization?.titleName ?? Constants.StringConstants.inboxTitleString
        self.customFont = inboxCustomization?.customFont ?? Constants.UIConstants.defaultFont(size: .title)
        self.titleFontColor = inboxCustomization?.titleFontColor ?? Constants.UIConstants.charcoalBlack
        self.titleBarBackgroundColor = inboxCustomization?.titleBarBackgroundColor ?? Constants.UIConstants.OpalColor

        // - sender cell
        self.senderShouldShowHeading = inboxCustomization?.senderShouldShowHeading ?? false
        self.senderCellMessageFont = inboxCustomization?.senderCellMessageFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.senderCellHeadingFont = inboxCustomization?.senderCellHeadingFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.senderCellTimeFont = inboxCustomization?.senderCellTimeFont ?? Constants.UIConstants.defaultFont(size: .callout)
        self.senderCellFontColor = inboxCustomization?.senderCellFontColor ?? Constants.UIConstants.charcoalBlack
        self.senderCellBackgroundColor = inboxCustomization?.senderCellBackgroundColor ?? Constants.UIConstants.DesertSandColor

        // receiver cell
        self.receiverCellMessageFont = inboxCustomization?.receiverCellMessageFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.receiverHeadingFont = inboxCustomization?.receiverHeadingFont ?? Constants.UIConstants.defaultFont(size: .subHeading)
        self.receiverCellTimeFont = inboxCustomization?.receiverCellTimeFont ?? Constants.UIConstants.defaultFont(size: .callout)
        self.receiverFontCellColor = inboxCustomization?.receiverFontCellColor ?? Constants.UIConstants.charcoalBlack
        self.receiverCellBackgroundColor = inboxCustomization?.receiverCellBackgroundColor ?? Constants.UIConstants.DesertSandColor

        // Chat textfield
        self.textFieldFont = inboxCustomization?.textFieldFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.textFieldPlaceholderText = inboxCustomization?.textFieldPlaceholderText ?? Constants.StringConstants.defaultPlaceholder
        self.textFieldBackgroundColor = inboxCustomization?.textFieldBackgroundColor ?? Constants.UIConstants.AlabasterColor
        self.textfieldAccentColor = inboxCustomization?.textfieldAccentColor ?? Constants.UIConstants.DesertSandColor
        self.textFieldFontColor = inboxCustomization?.textFieldFontColor ?? Constants.UIConstants.charcoalBlack
        self.buttonColor = inboxCustomization?.buttonColor ?? Constants.UIConstants.charcoalBlack
        self.mainBackground = inboxCustomization?.mainBackground ?? Constants.UIConstants.OpalColor
    }

    // Alert
    @Published var shouldPresentActionSheet : Bool = false

    // MARK: - Public methods
    func connect() {
        chatSocket.connect(onMessageReceiveEvent: { responseMessage, _  in
            self.chatMessages.append(ChatDataModel(message: responseMessage, userName: "User", imageUrl: "", timeStamp: self.getCurrentTime(), isMultimediaCell: nil, isSender: false))
        })
    }

    func sendMessage(text: String) {
        chatMessages.append(ChatDataModel(message: text, userName: "Manni", imageUrl: nil, timeStamp: getCurrentTime(), isMultimediaCell: nil, isSender: true))
        chatSocket.sendMessage(text)
    }

    func sendMultimediaMessage(image: String) {
        chatMessages.append(ChatDataModel(message: nil, userName: "Manni", imageUrl: "demoMessageImage", timeStamp: getCurrentTime(), isMultimediaCell: nil, isSender: true))
        chatSocket.sendMultimediaMessage(image)
    }

    // MARK: - private methods
    private func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringConstants.timeFormat
        let date = dateFormatter.string(from: Date())

        return eliminateZeroFromTime(timeString: date)
    }

    // ---- Timestamp
    private func getCurrentTimeStamp() -> Int {
        let timeStamp = Date().timeIntervalSince1970
        return Int(timeStamp) // will always be 10 Digits
    }

    private func resolveTimeStamp(_ timeStamp: Int) -> String {
        let timeInterval = TimeInterval(timeStamp)
        let rawDateinGMT = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringConstants.timeFormat
        let formattedDate = dateFormatter.string(from: rawDateinGMT as Date)

        return formattedDate
    }
    // ---- Timestamp

    func eliminateZeroFromTime(timeString: String ) -> String {
        var time = timeString

        if time.first == "0" {
            time.remove(at: time.startIndex)
        }

        return time
    }
}
