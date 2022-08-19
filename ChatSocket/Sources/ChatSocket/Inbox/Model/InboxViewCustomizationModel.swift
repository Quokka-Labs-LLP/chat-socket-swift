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
    public var titleName: String?
    public var customFont: Font?
    public var titleFontColor: Color?
    public var titleBarBackgroundColor: Color?

    // SENDER CHAT CELL
    public var senderShouldShowHeading: Bool?
    public var senderCellMessageFont: Font?
    public var senderCellHeadingFont: Font?
    public var senderCellTimeFont: Font?
    public var senderCellFontColor: Color?
    public var senderCellBackgroundColor: Color?

    // RECEIVER CHAT CELL
    public var receiverCellMessageFont: Font?
    public var receiverHeadingFont: Font?
    public var receiverCellTimeFont: Font?
    public var receiverFontCellColor: Color?
    public var receiverCellBackgroundColor: Color?

    // CHAT TEXTFIELD VIEW
    public var textFieldFont: Font?
    public var textFieldPlaceholderText: String?
    public var textFieldBackgroundColor: Color?
    public var textfieldAccentColor: Color?
    public var textFieldFontColor: Color?
    public var buttonColor: Color?
    public var mainBackground: Color?
}
