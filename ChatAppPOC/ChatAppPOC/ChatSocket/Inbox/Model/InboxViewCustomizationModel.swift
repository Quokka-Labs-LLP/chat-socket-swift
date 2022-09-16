//
//  InboxViewCustomizationModel.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 08/08/22.
//

import Foundation
import SwiftUI

public struct InboxViewCustomizationModel {
    // TITLE VIEW
    public var titleFont               : Font?
    public var titleFontColor          : Color?
    public var titleBarBackgroundColor : Color?
    public var titleBackButtonColor    : Color?
    public var titleMenuButtonColor    : Color?
    public var titleUserImageUrl       : String?

    // SENDER CHAT CELL
    public var senderShouldShowHeading     : Bool?
    public var senderCellMessageFont       : Font?
    public var senderCellHeadingFont       : Font?
    public var senderCellTimeFont          : Font?
    public var senderCellFontColor         : Color?
    public var senderCellBackgroundColor   : Color?

    // RECEIVER CHAT CELL
    public var receiverCellMessageFont     : Font?
    public var receiverHeadingFont         : Font?
    public var receiverCellTimeFont        : Font?
    public var receiverFontCellColor       : Color?
    public var receiverCellBackgroundColor : Color?

    // CHAT TEXTFIELD VIEW
    public var textFieldFont               : Font?
    public var textFieldPlaceholderText    : String?
    public var textFieldBackgroundColor    : Color?
    public var textfieldAccentColor        : Color?
    public var textFieldFontColor          : Color?
    public var textFieldSendbuttonColor                : Color?
    public var textFieldContainerMainBackgroundColor   : Color?
    public var textFieldShouldShowGalleryButton        : Bool?

    // MAIN
    public var mainBackgroundColor         : Color?

    // Initializer
    public init () { }
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
