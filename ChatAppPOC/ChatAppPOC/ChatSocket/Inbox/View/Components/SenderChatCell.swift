//
//  ChatCell.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

struct SenderChatCell: View {
    // MARK: - Properties
    // Data
    let chatData : ChatDataModel
    let inboxViewVM : InboxViewVM
    // private
    private let alignment : HorizontalAlignment = .trailing

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Spacer()
            VStack(alignment: .trailing, spacing: 5, content: {
                // Head
                if let userName = chatData.userName, inboxViewVM.senderShouldShowHeading {
                    Text(userName)
                        .foregroundColor(inboxViewVM.senderCellFontColor)
                        .font(inboxViewVM.senderCellHeadingFont)
                        .bold()
                }

                // message body
                if let message = chatData.message, let time = chatData.timeStamp {
                    Text(message)
                        .foregroundColor(inboxViewVM.senderCellFontColor)
                        .font(inboxViewVM.senderCellMessageFont)
                        .multilineTextAlignment(.leading)
                    Text(time)
                        .foregroundColor(inboxViewVM.senderCellFontColor)
                        .font(inboxViewVM.senderCellTimeFont)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                }

            })
            .frame(alignment: .trailing).padding(5)
            .background(inboxViewVM.senderCellBackgroundColor).cornerRadius(Constants.UIConstants.chatCellCornerRadius).padding(3)
        })
        .padding(.leading, 25)

    }
}

struct ChatCell_Previews: PreviewProvider {
    static var previews: some View {
        SenderChatCell(
            chatData: ChatDataModel(message: "Hello World", userName: "Manni", imageUrl: "", timeStamp: "10:00 AM", isMultimediaCell: nil, isSender: true), inboxViewVM: InboxViewVM(titleName: "", chatSocket: ChatSocket.sharedInstance, inboxCustomization: nil))
            .previewLayout(.sizeThatFits)
    }
}
