//
//  ReceiverMultimediaChatCell.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

struct ReceiverMultimediaChatCell: View {
    // MARK: - Properties
    // Data
    let chatData : ChatDataModel
    let inboxViewVM : InboxViewVM

    // private
    private let alignment : HorizontalAlignment = .trailing
    @State private var shouldPresent : Bool = false

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Spacer()
            VStack(alignment: .trailing, spacing: 5, content: {
                // Head
                if let userName = chatData.userName {
                    Text(userName)
                        .foregroundColor(inboxViewVM.receiverCellFontColor)
                        .font(inboxViewVM.receiverCellHeadingFont)
                        .bold()
                }

                // message body
                if let imageUrl = chatData.imageUrl {
                    // set image using url
                    Button(action: {
                        withAnimation(Animation.easeInOut, {
                            shouldPresent.toggle()
                        })
                    }, label: {
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                            Text(imageUrl) // TuDu: - Remove this when image functionality is added, this is only for demo purose.

                            Image(imageUrl)
                                .resizable()
                                .scaledToFill()
                                .frame(width: Constants.UIConstants.screenWidth - 100, height: Constants.UIConstants.screenWidth - 200, alignment: .center)
                                .cornerRadius(Constants.UIConstants.standardCornerRadius)
                                .padding(5)
                        })
                    }).fullScreenCover(isPresented: $shouldPresent, content: {
                        ImagePreviewer(image: Image(imageUrl))
                    })
                }

                if let time = chatData.timeStamp {
                    Text(time)
                        .foregroundColor(inboxViewVM.receiverCellFontColor)
                        .font(inboxViewVM.receiverCellTimeFont)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                }

            })
            .frame(alignment: .trailing)
            .padding(5)
            .background(inboxViewVM.receiverCellBackgroundColor)
            .cornerRadius(Constants.UIConstants.chatCellCornerRadius)
            .padding(3)
        })
    }
}

struct ReceiverMultimediaChatCell_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverMultimediaChatCell(
            chatData: ChatDataModel(
                message: "",
                userName: "",
                imageUrl: "",
                timeStamp: "",
                isMultimediaCell: true,
                isSender: true
            ),
            inboxViewVM: InboxViewVM(titleName: "titleName", chatSocket: ChatSocket.sharedInstance)
        )
    }
}
