//
//  ChatListVM.swift
//  ChatSocketExample
//
//  Created by Valkyrie on 26/08/22.
//

import Foundation
import ChatSocket
import SwiftUI

/// View Model for Chat List View.
class ChatListVM : ObservableObject {

    //MARK: - properties
    let chatDataModel = ChatDataModel()

    //MARK: - Methods
    /// This method explains all the customizations available for reusable `InboxView` from chat socket, implemented in `ChatListView`
    /// - Returns: `Customized instance for InboxView`
    func getCustomization() -> InboxViewCustomizationModel {
        var customizationModal = InboxViewCustomizationModel()

        customizationModal.titleBackButtonColor = .white
        customizationModal.titleFontColor = .white
        customizationModal.titleMenuButtonColor = .white
        customizationModal.titleBarBackgroundColor = .gray
        customizationModal.titleFont = Font.custom(StringConstants.fontMontserratLight, size: 30)
        customizationModal.titleFontColor = .mint

        return customizationModal
    }
}
