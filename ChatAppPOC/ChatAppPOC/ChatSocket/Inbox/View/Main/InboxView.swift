//
//  ContentView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

public struct InboxView: View {
    // MARK: - properties
    @ObservedObject var inboxViewVM: InboxViewVM
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @State var shouldPresent : Bool = false

    // MARK: - Init
    // get required customizations from user and store them in ViewModel.
    public init(titleName : String, chatSocket: ChatSocket, inboxCustomization : InboxViewCustomizationModel? = nil) {
        inboxViewVM = InboxViewVM(titleName: titleName, chatSocket: chatSocket, inboxCustomization: inboxCustomization)
    }

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0 ) {
            // Header
            TitleView(inboxViewVM: inboxViewVM, menuAction: {
                inboxViewVM.shouldPresentActionSheet = true
            }, backAction: {
                mode.projectedValue.wrappedValue.dismiss()
            }, imageAction: {

                /* Need to Decide */
                // - Can open image previewer.
                // - Can give callback to parent view as well.

            }).confirmationDialog(Constants.StringConstants.chatMenuTitle, isPresented: $inboxViewVM.shouldPresentActionSheet, actions: {
                Button(Constants.StringConstants.connectToServer, role: .destructive, action: {
                    inboxViewVM.connect()
                })
                Button(Constants.StringConstants.cancelText, role: .cancel, action: {})
            })

            // message listing
            ScrollView(content: {
                ScrollViewReader(content: { scrollView in
                    VStack {
                        EmptyView()
                        ForEach(inboxViewVM.chatMessages) { chatMessage in
                            if let isSender = chatMessage.isSender, isSender {
                                if let isMultimediaCell = chatMessage.isMultimediaCell, isMultimediaCell {
                                    SenderMultimediaChatCell(chatData: chatMessage, inboxViewVM: inboxViewVM).id(chatMessage.id)
                                } else {
                                    SenderChatCell(chatData: chatMessage, inboxViewVM: inboxViewVM).id(chatMessage.id)
                                }
                            } else {

                                if let isMultimediaCell = chatMessage.isMultimediaCell, isMultimediaCell {
                                    ReceiverMultimediaChatCell(chatData: chatMessage, inboxViewVM: inboxViewVM).id(chatMessage.id)
                                } else {
                                    ReceiverChatCell(chatData: chatMessage, inboxViewVM: inboxViewVM).id(chatMessage.id)
                                }
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
                })
            }).background(.clear)

            // Wear helmet,this Might crash.
            if let pickedImage = $inboxViewVM.pickedImage {
                if let pickedImg = pickedImage.wrappedValue {
                    Button(action: {
                        withAnimation(Animation.easeInOut, {
                            shouldPresent.toggle()
                        })
                    }, label: {
                        Image(uiImage: pickedImg)
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                    }).fullScreenCover(isPresented: $shouldPresent, content: {
                        ImagePreviewer(image: Image(uiImage: pickedImg))
                    })
                }
            }

            // Chat button tapped
            ChatTextfieldView(inboxViewVM: inboxViewVM, chatButtonAction: { text in
                inboxViewVM.sendMessage(text: text)
            })
        }
        .background(inboxViewVM.mainBackgroundColor)
        .gesture(
            DragGesture(minimumDistance: 2, coordinateSpace: .local).onChanged({ value in
            if value.translation.height > 0 {
                hideKeyboard()
            }})
        )
        .navigationBarHidden(true)
        .onTapGesture {
            hideKeyboard()
        }

    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(titleName: Constants.StringConstants.chatMenuTitle, chatSocket: ChatSocket.sharedInstance)
    }
}
