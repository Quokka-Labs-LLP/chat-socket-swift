//
//  Constants.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import UIKit
import SwiftUI

struct Constants {
    // MARK: - Font sizes
    enum FontSizes: CGFloat {
        case title = 28
        case Heading = 22
        case subHeading = 18
        case body = 16
        case callout = 11
    }

    // MARK: - UI
    struct UIConstants {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let chatCellCornerRadius: CGFloat = 10
        static let textFieldCornerRadius: CGFloat = 5
        static let colorOpacity: CGFloat = 0.7

        static func defaultFont(size: FontSizes = .Heading) -> Font {
            let string: CFString = "SF-Pro" as CFString
            return Font(CTFont(string, size: size.rawValue))
        }

        // Colors
        static let charcoalBlack: Color = Color(.sRGB, red: 33.0 / 255.0, green: 33.0 / 255.0, blue: 33.0 / 255.0, opacity: 1.0)
        static let opalColor: Color = Color(.sRGB, red: 174.0 / 255.0, green: 195.0 / 255.0, blue: 193.0 / 255.0, opacity: 1.0)
        static let desertSandColor: Color = Color(.sRGB, red: 237.0 / 255.0, green: 212.0 / 255.0, blue: 181.0 / 255.0, opacity: 1.0)
        static let alabasterColor: Color = Color(.sRGB, red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 233.0 / 255.0, opacity: 1.0)
        static let pastelGrayColor: Color = Color(.sRGB, red: 209.0 / 255.0, green: 205.0 / 255.0, blue: 199.0 / 255.0, opacity: 1.0)
    }

    // MARK: - String
    struct StringConstants {
        static let defaultPlaceholder = "Type here..."
        static let emptyString = ""
        static let chatMenuTitle = "Chat Menu"
        static let cancelText = "Cancel"
        static let connectToServer = "Connect to server?"

        // Errors and Logging
        static let connectionRequest = "Connection Request"
        static let disconnectionRequest = "Disconnection Request"
        static let connectionSuccessfull = "Socket Connection Successful"
        static let disconnectionSuccessfull = "Disconnected sucessfully"
        static let startedListeningForEvent = "Started listening for event"
        static let serverResponse = "Server Response"
        static let sendingMessage = "Sending message"

        // TODO: - Remove Later, Only for demonstration
        static let inboxTitleString = "jarvis"

    }
}
