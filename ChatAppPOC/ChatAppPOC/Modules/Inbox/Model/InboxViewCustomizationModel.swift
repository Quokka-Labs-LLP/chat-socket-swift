//
//  InboxViewCustomizationModel.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 08/08/22.
//

import Foundation
import SwiftUI

struct InboxViewCustomizationModel {
    // TITLE VIEW
    var titleName               : String?
    var customFont              : Font?
    var titleFontColor          : Color?
    var titleBarBackgroundColor  : Color?
    // TUDU :
    // - backButtonColor
    // - menu buttonColor

    // SENDER CHAT CELL
    var senderShouldShowHeading     : Bool?
    var senderCellMessageFont       : Font?
    var senderCellHeadingFont       : Font?
    var senderCellTimeFont          : Font?
    var senderCellFontColor         : Color?
    var senderCellBackgroundColor   : Color?

    // RECEIVER CHAT CELL
    var receiverCellMessageFont     : Font?
    var receiverHeadingFont         : Font?
    var receiverCellTimeFont        : Font?
    var receiverFontCellColor       : Color?
    var receiverCellBackgroundColor : Color?

    // CHAT TEXTFIELD VIEW
    var textFieldFont               : Font?
    var textFieldPlaceholderText    : String?
    var textFieldBackgroundColor    : Color?
    var textfieldAccentColor        : Color?
    var textFieldFontColor          : Color?
    var buttonColor                 : Color?
    var mainBackground              : Color?
    var shouldShowGalleryButton     : Bool?

    // MAIN
    var mainBackgroundColor         : Color?
}

enum InboxViewCustomizationModelEnum {
    // TITLE VIEW
    case titleName
    case customFont
    case titleFontColor
    case titleBarBackgroundColor

    // SENDER CHAT CELL
    case senderShouldShowHeading
    case senderCellMessageFont
    case senderCellHeadingFont
    case senderCellTimeFont
    case senderCellFontColor
    case senderCellBackgroundColor

    // RECEIVER CHAT CELL
    case receiverCellMessageFont
    case receiverHeadingFont
    case receiverCellTimeFont
    case receiverFontCellColor
    case receiverCellBackgroundColor

    // CHAT TEXTFIELD VIEW
    case textFieldFont
    case textFieldPlaceholderText
    case textFieldBackgroundColor
    case textfieldAccentColor
    case textFieldFontColor
    case buttonColor
    case mainBackground
}
