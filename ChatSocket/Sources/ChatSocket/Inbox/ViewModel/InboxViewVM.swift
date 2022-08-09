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
        let chatSocket = ChatSocket.sharedInstance
        chatSocket.urlString = "ws://localhost:3000"
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
    var titleBarBackgroundColor  : Color     = Constants.UIConstants.OpalColor
    
    // CHAT CELL
    // - Sender
    var senderShouldShowHeading     : Bool = false
    var senderCellMessageFont       : Font = Constants.UIConstants.defaultFont(size: .body)
    var senderCellHeadingFont       : Font = Constants.UIConstants.defaultFont(size: .body)
    var senderCellTimeFont          : Font = Constants.UIConstants.defaultFont(size: .callout)
    var senderCellFontColor         : Color = Constants.UIConstants.charcoalBlack
    var senderCellBackgroundColor   : Color = Constants.UIConstants.DesertSandColor
    
    // - Receiver
    var receiverCellMessageFont     : Font = Constants.UIConstants.defaultFont(size: .body)
    var receiverHeadingFont         : Font = Constants.UIConstants.defaultFont(size: .subHeading)
    var receiverCellTimeFont        : Font = Constants.UIConstants.defaultFont(size: .callout)
    var receiverFontCellColor       : Color = Constants.UIConstants.charcoalBlack
    var receiverCellBackgroundColor : Color = Constants.UIConstants.DesertSandColor
    
    //CHAT TEXTFIELD VIEW
    var textFieldFont : Font = Constants.UIConstants.defaultFont(size: .body)
    var textFieldPlaceholderText : String = Constants.StringConstants.defaultPlaceholder
    var textFieldBackgroundColor : Color = Constants.UIConstants.AlabasterColor
    var textfieldAccentColor : Color = Constants.UIConstants.DesertSandColor
    var textFieldFontColor : Color = Constants.UIConstants.charcoalBlack
    var buttonColor : Color = Constants.UIConstants.charcoalBlack
    var mainBackground : Color = Constants.UIConstants.OpalColor
    
    //Alert
    @Published var shouldPresentActionSheet : Bool = false
    
    //MARK: - Public methods
    func connect() {
        chatSocket.connect()
    }
    
    func sendMessage(text: String) {
        chatMessages.append(ChatDataModel(message: text, userName: "Manni", imageUrl: "", time: getCurrentTime(), isSender: true))
        
        chatSocket.sendMessage(text, { responseMessage in
            self.chatMessages.append(ChatDataModel(message: responseMessage, userName: "Jarvis", imageUrl: "", time: self.getCurrentTime(), isSender: false))
        })
        
    }
    
    //MARK: - private methods
    private func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: Date())
        
        return date
    }
    
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
        
        // want to keep the properties individual because we will need to unwrap the values to implement them in View.
        //        DispatchQueue.main.async {
        //            newCustomization.titleName = customization.titleName ?? Constants.StringConstants.inboxTitleString
        //            newCustomization.customFont   = customization.customFont ?? Constants.UIConstants.defaultFont(size: .title)
        //            newCustomization.titleFontColor  = customization.titleFontColor ?? Constants.UIConstants.charcoalBlack
        //            newCustomization.titleBarBackgroundColor  = customization.titleBarBackgroundColor ?? Constants.UIConstants.OpalColor
        //
        //            // CHAT CELL
        //            // - Sender
        //            newCustomization.senderShouldShowHeading = customization.senderShouldShowHeading ?? false
        //            newCustomization.senderCellMessageFont = customization.senderCellMessageFont ?? Constants.UIConstants.defaultFont(size: .body)
        //            newCustomization.senderCellHeadingFont = customization.senderCellHeadingFont ?? Constants.UIConstants.defaultFont(size: .body)
        //            newCustomization.senderCellTimeFont = customization.senderCellTimeFont ?? Constants.UIConstants.defaultFont(size: .callout)
        //            newCustomization.senderCellFontColor = customization.senderCellFontColor ?? Constants.UIConstants.charcoalBlack
        //            newCustomization.senderCellBackgroundColor = customization.senderCellBackgroundColor ?? Constants.UIConstants.DesertSandColor
        //
        //            // - Receiver
        //            newCustomization.receiverCellMessageFont  = customization.receiverCellMessageFont ?? Constants.UIConstants.defaultFont(size: .body)
        //            newCustomization.receiverHeadingFont  = customization.receiverHeadingFont ?? Constants.UIConstants.defaultFont(size: .subHeading)
        //            newCustomization.receiverCellTimeFont  = customization.receiverCellTimeFont ?? Constants.UIConstants.defaultFont(size: .callout)
        //            newCustomization.receiverFontCellColor  = customization.receiverFontCellColor ?? Constants.UIConstants.charcoalBlack
        //            newCustomization.receiverCellBackgroundColor  = customization.receiverCellBackgroundColor ?? Constants.UIConstants.DesertSandColor
        //
        //            //CHAT TEXTFIELD VIEW
        //            newCustomization.textFieldFont  = customization.textFieldFont ?? Constants.UIConstants.defaultFont(size: .body)
        //            newCustomization.textFieldPlaceholderText  = customization.textFieldPlaceholderText ?? Constants.StringConstants.defaultPlaceholder
        //            newCustomization.textFieldBackgroundColor  = customization.textFieldBackgroundColor ?? Constants.UIConstants.AlabasterColor
        //            newCustomization.textfieldAccentColor  = customization.textfieldAccentColor ?? Constants.UIConstants.DesertSandColor
        //            newCustomization.textFieldFontColor  = customization.textFieldFontColor ?? Constants.UIConstants.charcoalBlack
        //            newCustomization.buttonColor  = customization.buttonColor ?? Constants.UIConstants.charcoalBlack
        //            newCustomization.mainBackground  = customization.mainBackground ?? Constants.UIConstants.OpalColor
        //
        //            self.inboxCustomization = newCustomization
        //        }
    }
        
        
}
