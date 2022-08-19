//
//  ContentView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

public struct InboxView: View {
    // MARK: - properties
    @ObservedObject var inboxViewVM = InboxViewVM()

    // MARK: - Init
    // get required customizations from user and store them in ViewModel.
    public init(_ customization: InboxViewCustomizationModel? = nil) {
        inboxViewVM.inboxCustomization = customization
    }

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0 ) {
            // Header
            TitleView(title: inboxViewVM.titleName, titleFont: inboxViewVM.customFont, titleFontColor: inboxViewVM.titleFontColor, titleBarBackroundColor: inboxViewVM.titleBarBackgroundColor, menuAction: {
                inboxViewVM.shouldPresentActionSheet = true
            }, backAction: {

            }).confirmationDialog(Constants.StringConstants.chatMenuTitle, isPresented: $inboxViewVM.shouldPresentActionSheet, actions: {
                Button(Constants.StringConstants.connectToServer, role: .destructive, action: {
                    inboxViewVM.connect()
                })
                Button(Constants.StringConstants.cancelText, role: .cancel, action: {})
            })

            // message listing
            ScrollView(content: {
                VStack {
                    EmptyView()
                    ForEach(inboxViewVM.chatMessages) { chatMessage in
                        if let isSender = chatMessage.isSender, isSender {
                            SenderChatCell(senderShouldShowHeading: inboxViewVM.senderShouldShowHeading, senderCellMessageFont: inboxViewVM.senderCellMessageFont, senderCellHeadingFont: inboxViewVM.senderCellHeadingFont, senderCellTimeFont: inboxViewVM.senderCellTimeFont, senderCellFontColor: inboxViewVM.senderCellFontColor, senderCellBackgroundColor: inboxViewVM.senderCellBackgroundColor, chatData: chatMessage)
                        } else {
                            ReceiverChatCell(receiverCellMessageFont: inboxViewVM.receiverCellMessageFont, receiverCellHeadingFont: inboxViewVM.receiverHeadingFont, receiverCellTimeFont: inboxViewVM.receiverCellTimeFont, receiverCellFontColor: inboxViewVM.receiverFontCellColor, receiverCellBackgroundColor: inboxViewVM.receiverCellBackgroundColor, chatData: chatMessage)
                        }
                    }
                }.padding(.vertical)
            }).background(.clear)

            // Chat button tapped
            ChatTextfieldView(textFieldFont: inboxViewVM.textFieldFont, textFieldPlaceholderText: inboxViewVM.textFieldPlaceholderText, textFieldBackgroundColor: inboxViewVM.textFieldBackgroundColor, textfieldAccentColor: inboxViewVM.textfieldAccentColor, textFieldFontColor: inboxViewVM.textFieldFontColor, buttonColor: inboxViewVM.buttonColor, mainBackground: inboxViewVM.mainBackground, chatButtonAction: { text in
                inboxViewVM.sendMessage(text: text)
            })
        }
        .background(Constants.UIConstants.alabasterColor)
        .navigationBarHidden(true)

    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(InboxViewCustomizationModel(titleName: Constants.StringConstants.chatMenuTitle))
    }
}
