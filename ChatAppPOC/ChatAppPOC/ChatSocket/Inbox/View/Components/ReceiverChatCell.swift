//
//  ReceiverChatCell.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

struct ReceiverChatCell: View {
    // MARK: - Properties
    // Data
    let chatData : ChatDataModel
    let inboxViewVM : InboxViewVM

    // private
    private let alignment : HorizontalAlignment = .trailing

    var body: some View {
        // For Sender
        HStack(alignment: .center, spacing: 0, content: {
            // message body
            VStack(alignment: .leading, spacing: 5, content: {
                if let message = chatData.message, let time = chatData.timeStamp, let userName = chatData.userName {
                    Text(userName)
                        .font(inboxViewVM.receiverCellHeadingFont)
                        .foregroundColor(inboxViewVM.receiverCellFontColor)
                        .bold()
                    Text(message)
                        .font(inboxViewVM.receiverCellMessageFont)
                        .foregroundColor(inboxViewVM.receiverCellFontColor)
                        .multilineTextAlignment(.leading)
                    Text(time)
                        .font(inboxViewVM.receiverCellTimeFont)
                        .foregroundColor(inboxViewVM.receiverCellFontColor)
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 10)
                }
            })
            .frame(alignment: .leading)
            .padding(5)
            .background(inboxViewVM.receiverCellBackgroundColor)
            .cornerRadius(Constants.UIConstants.chatCellCornerRadius)
            .padding(3)
            //
            Spacer()
        })
    }
}

struct ReceiverChatCell_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverChatCell(
            chatData: ChatDataModel(message : "Hii This is temp message", userName : "Manni", imageUrl: "", timeStamp: "10:00 am", isMultimediaCell: false, isSender  : false), inboxViewVM: InboxViewVM(titleName: "titleName", chatSocket: ChatSocket.sharedInstance))
            .previewLayout(.sizeThatFits)
    }
}
