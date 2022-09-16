//
//  ListingViewVM.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 02/09/22.
//

import Foundation

class ListingViewVM : ObservableObject {
    // MARK: - Properties
    @Published var shouldMove = false
    @Published var shouldPresentActionSheet = false
    @Published var selectedFriend : String = ""

    let friends : [String] = ["User 1", "User 2"]

    /// Inbox view customization Example
    /// - Returns: Instance of InboxViewCustomizationModel
    func getCustomization() -> InboxViewCustomizationModel {
        var customizationModal = InboxViewCustomizationModel()
        customizationModal.titleBackButtonColor = .red
        customizationModal.titleFontColor = .green
        customizationModal.titleMenuButtonColor = .purple
        customizationModal.titleBarBackgroundColor = .orange

        customizationModal.senderCellBackgroundColor = .gray
        customizationModal.receiverCellBackgroundColor = .white

        customizationModal.textFieldSendbuttonColor = .yellow
        customizationModal.textfieldAccentColor = .indigo
        customizationModal.textFieldFontColor = .mint
        customizationModal.textFieldContainerMainBackgroundColor = .red

        customizationModal.mainBackgroundColor = .brown

        return customizationModal
    }

    func inboxView() -> InboxView {
        InboxView(titleName: selectedFriend, chatSocket: getChatSocket(), inboxCustomization: getCustomization())
    }

    func getChatSocket() -> ChatSocket {
        let chatSocket = ChatSocket.sharedInstance

        chatSocket.urlString = "ws://localhost:3000"
        chatSocket.isLoggingEnabled = true

        chatSocket.messageSendEvent = "newMessage"
        chatSocket.messageReceiveEvent = "newMessage"

        return chatSocket
    }
}
