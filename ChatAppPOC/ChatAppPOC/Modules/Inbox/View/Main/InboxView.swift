//
//  ContentView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

protocol InboxViewDelegate {
    func menuButtonTapped()
}

struct InboxView: View {
    //MARK: - properties
    @ObservedObject var inboxViewVM = InboxViewVM()
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    //var delegate : InboxViewDelegate?
    
    
    //MARK: - Init
    // get required customizations from user and store them in ViewModel.
    init(customization : InboxViewCustomizationModel? = nil) {
        inboxViewVM.inboxCustomization = customization
    }
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 0 ) {
            //Header
            TitleView(title: inboxViewVM.titleName, titleFont: inboxViewVM.customFont, titleFontColor: inboxViewVM.titleFontColor, titleBarBackroundColor: inboxViewVM.titleBarBackgroundColor, menuAction: {
                inboxViewVM.shouldPresentActionSheet = true
            }, backAction: {
                mode.projectedValue.wrappedValue.dismiss()
            }, imageAction: {
                
                /**** Need to Decide */
                // - Can open image previewer.
                // - Can give callback to parent view as well.
                
            }).confirmationDialog(Constants.StringConstants.chatMenuTitle, isPresented: $inboxViewVM.shouldPresentActionSheet, actions: {
                Button(Constants.StringConstants.connectToServer, role: .destructive, action: {
                    inboxViewVM.connect()
                })
                Button(Constants.StringConstants.cancelText, role: .cancel, action: {})
            })
            
            //message listing
            ScrollView(content: {
                ScrollViewReader(content: { scrollView in
                    VStack {
                        EmptyView()
                        ForEach(inboxViewVM.chatMessages) { chatMessage in
                            if let isSender = chatMessage.isSender, isSender {
                                if let isMultimediaCell = chatMessage.isMultimediaCell, isMultimediaCell {
                                    SenderMultimediaChatCell(senderShouldShowHeading: inboxViewVM.senderShouldShowHeading, senderCellMessageFont: inboxViewVM.senderCellMessageFont, senderCellHeadingFont: inboxViewVM.senderCellHeadingFont, senderCellTimeFont: inboxViewVM.senderCellTimeFont, senderCellFontColor: inboxViewVM.senderCellFontColor, senderCellBackgroundColor: inboxViewVM.senderCellBackgroundColor, chatData: chatMessage).id(chatMessage.id)
                                } else {
                                    SenderChatCell(senderShouldShowHeading: inboxViewVM.senderShouldShowHeading, senderCellMessageFont: inboxViewVM.senderCellMessageFont, senderCellHeadingFont: inboxViewVM.senderCellHeadingFont, senderCellTimeFont: inboxViewVM.senderCellTimeFont, senderCellFontColor: inboxViewVM.senderCellFontColor, senderCellBackgroundColor: inboxViewVM.senderCellBackgroundColor, chatData: chatMessage).id(chatMessage.id)
                                }
                                
                                
                            } else {
                                ReceiverChatCell(receiverCellMessageFont: inboxViewVM.receiverCellMessageFont, receiverCellHeadingFont: inboxViewVM.receiverHeadingFont, receiverCellTimeFont: inboxViewVM.receiverCellTimeFont, receiverCellFontColor: inboxViewVM.receiverFontCellColor, receiverCellBackgroundColor: inboxViewVM.receiverCellBackgroundColor, chatData: chatMessage).id(chatMessage.id)
                            }
                        }
                    }
                    .padding(.vertical)
                    .onChange(of: inboxViewVM.chatMessages.last?.id, perform: { id in
                        withAnimation {
                            // will scroll the scrollview to last sent message on send and receive.
                            scrollView.scrollTo(id)
                        }
                    })
                    //TODO: - Also scroll to last message on loading the screen
                })
            }).background(.clear)
            
            //Chat button tapped
            ChatTextfieldView(textFieldFont: inboxViewVM.textFieldFont, textFieldPlaceholderText: inboxViewVM.textFieldPlaceholderText, textFieldBackgroundColor: inboxViewVM.textFieldBackgroundColor, textfieldAccentColor: inboxViewVM.textfieldAccentColor, textFieldFontColor: inboxViewVM.textFieldFontColor, buttonColor: inboxViewVM.buttonColor, mainBackground: inboxViewVM.mainBackground, chatButtonAction: { text in
                inboxViewVM.sendMessage(text: text)
            })
        }
        //TODO: - get main background in init.
        .background(Constants.UIConstants.AlabasterColor)
        .navigationBarHidden(true)
    
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(customization: InboxViewCustomizationModel(titleName: Constants.StringConstants.chatMenuTitle))
    }
}
