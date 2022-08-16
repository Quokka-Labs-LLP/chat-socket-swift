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
    //MARK: - Properties
    let urlString = "ws://localhost:3000"
    var socketManager : SocketManager?
    var socket : SocketIOClient?
    var inboxCustomization : InboxViewCustomizationModel? {
        didSet {
            if let inboxCustomization = inboxCustomization {
                setupCustomizations(inboxCustomization)
            }
        }
    }
    
    var chatSocket : ChatSocket = {
        /// URL for local host ws://localhost:3000
        let chatSocket = ChatSocket.sharedInstance
        chatSocket.urlString = "http://3.143.67.28:3000"
        //chatSocket.urlString = "ws://localhost:3000"
        chatSocket.messageSendEvent = "newMessage"
        chatSocket.messageReceiveEvent = "newMessage"
        return chatSocket
    }()
    
    //Published
    @Published var chatMessages : [ChatDataModel] = []
    
    //TODO: group all these properties using struct or enum.
    // Customization options and default values
    // TITLE VIEW
    var titleName               : String    = Constants.StringConstants.inboxTitleString
    var customFont              : Font      = Constants.UIConstants.defaultFont(size: .title)
    var titleFontColor          : Color     = Constants.UIConstants.charcoalBlack
    var titleBarBackgroundColor  : Color     = Constants.UIConstants.opalColor
    
    // CHAT CELL
    // - Sender
    var senderShouldShowHeading     : Bool = false
    var senderCellMessageFont       : Font = Constants.UIConstants.defaultFont(size: .body)
    var senderCellHeadingFont       : Font = Constants.UIConstants.defaultFont(size: .body)
    var senderCellTimeFont          : Font = Constants.UIConstants.defaultFont(size: .callout)
    var senderCellFontColor         : Color = Constants.UIConstants.charcoalBlack
    var senderCellBackgroundColor   : Color = Constants.UIConstants.desertSandColor
    
    // - Receiver
    var receiverCellMessageFont     : Font = Constants.UIConstants.defaultFont(size: .body)
    var receiverHeadingFont         : Font = Constants.UIConstants.defaultFont(size: .subHeading)
    var receiverCellTimeFont        : Font = Constants.UIConstants.defaultFont(size: .callout)
    var receiverFontCellColor       : Color = Constants.UIConstants.charcoalBlack
    var receiverCellBackgroundColor : Color = Constants.UIConstants.desertSandColor
    
    //CHAT TEXTFIELD VIEW
    var textFieldFont : Font = Constants.UIConstants.defaultFont(size: .body)
    var textFieldPlaceholderText : String = Constants.StringConstants.defaultPlaceholder
    var textFieldBackgroundColor : Color = Constants.UIConstants.alabasterColor
    var textfieldAccentColor : Color = Constants.UIConstants.desertSandColor
    var textFieldFontColor : Color = Constants.UIConstants.charcoalBlack
    var buttonColor : Color = Constants.UIConstants.charcoalBlack
    var mainBackground : Color = Constants.UIConstants.opalColor
    
    //Alert
    @Published var shouldPresentActionSheet : Bool = false
    
    //MARK: - Public methods
    func connect() {
        chatSocket.connect({ responseMessage in
            
            self.chatMessages.append(ChatDataModel(message: responseMessage, userName: Constants.StringConstants.inboxTitleString, imageUrl: "", timeStamp: self.getCurrentTime(), isSender: false))
        })
    }
    
    func sendMessage(text: String) {
        chatMessages.append(ChatDataModel(message: text, userName: "Manni", imageUrl: "", timeStamp: getCurrentTime(), isSender: true))
        
        chatSocket.sendMessage(text)
        
    }
    
    //MARK: - private methods
    private func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: Date())
        
        return date
    }
    
    //---- Timestamp
    private func getCurrentTimeStamp() -> Int {
        let timeStamp = Date().timeIntervalSince1970
        return Int(timeStamp) // will always be 10 Digits
    }
    
    private func resolveTimeStamp(_ timeStamp: Int) -> String {
        let timeInterval = TimeInterval(timeStamp)
        let rawDateinGMT = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let formattedDate = dateFormatter.string(from: rawDateinGMT as Date)
        return formattedDate
    }
    //---- Timestamp
    
    private func setupCustomizations(_ customization: InboxViewCustomizationModel) {
        DispatchQueue.main.async {
            // - title view
            if let titleName = customization.titleName {self.titleName = titleName }
            if let customFont = customization.customFont { self.customFont = customFont }
            if let titleFontColor = customization.titleFontColor { self.titleFontColor = titleFontColor }
            if let titleBarBackgroundColor = customization.titleBarBackgroundColor { self.titleBarBackgroundColor = titleBarBackgroundColor }
            
            // - sender cell
            if let senderShouldShowHeading = customization.senderShouldShowHeading { self.senderShouldShowHeading = senderShouldShowHeading}
            if let senderCellMessageFont = customization.senderCellMessageFont { self.senderCellMessageFont = senderCellMessageFont }
            if let senderCellHeadingFont = customization.senderCellHeadingFont { self.senderCellHeadingFont = senderCellHeadingFont  }
            if let senderCellTimeFont = customization.senderCellTimeFont { self.senderCellTimeFont = senderCellTimeFont  }
            if let senderCellFontColor = customization.senderCellFontColor { self.senderCellFontColor = senderCellFontColor  }
            if let senderCellBackgroundColor = customization.senderCellBackgroundColor { self.senderCellBackgroundColor = senderCellBackgroundColor  }
            
            // receiver cell
            if let receiverCellMessageFont     = customization.receiverCellMessageFont { self.receiverCellMessageFont = receiverCellMessageFont }
            if let receiverHeadingFont         = customization.receiverHeadingFont { self.receiverHeadingFont = receiverHeadingFont }
            if let receiverCellTimeFont        = customization.receiverCellTimeFont { self.receiverCellTimeFont = receiverCellTimeFont }
            if let receiverFontCellColor       = customization.receiverFontCellColor { self.receiverFontCellColor = receiverFontCellColor }
            if let receiverCellBackgroundColor = customization.receiverCellBackgroundColor { self.receiverCellBackgroundColor = receiverCellBackgroundColor }
            
            // Chat textfield
            if let textFieldFont = customization.textFieldFont { self.textFieldFont = textFieldFont }
            if let textFieldPlaceholderText = customization.textFieldPlaceholderText { self.textFieldPlaceholderText = textFieldPlaceholderText }
            if let textFieldBackgroundColor = customization.textFieldBackgroundColor { self.textFieldBackgroundColor = textFieldBackgroundColor }
            if let textfieldAccentColor = customization.textfieldAccentColor { self.textfieldAccentColor = textfieldAccentColor }
            if let textFieldFontColor = customization.textFieldFontColor { self.textFieldFontColor = textFieldFontColor }
            if let buttonColor = customization.buttonColor { self.buttonColor = buttonColor }
            if let mainBackground = customization.mainBackground { self.mainBackground = mainBackground }
        }
    }
        
        
}
