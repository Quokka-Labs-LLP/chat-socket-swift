//
//  ReceiverChatCell.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

struct ReceiverChatCell: View {
    //MARK: - Properties
    //Customization
    let receiverCellMessageFont       : Font
    let receiverCellHeadingFont       : Font
    let receiverCellTimeFont          : Font
    let receiverCellFontColor         : Color
    let receiverCellBackgroundColor   : Color
    
    //Data
    let chatData : ChatDataModel
    
    //private
    private let alignment : HorizontalAlignment = .trailing
    
    var body: some View {
        // For Sender
        HStack(alignment: .center, spacing: 0, content: {
            // message body
            VStack(alignment: .leading, spacing: 5, content: {
                if let message = chatData.message, let time = chatData.timeStamp, let userName = chatData.userName {
                    Text(userName)
                        .font(receiverCellHeadingFont)
                        .foregroundColor(receiverCellFontColor)
                        .bold()
                    Text(message)
                        .font(receiverCellMessageFont)
                        .foregroundColor(receiverCellFontColor)
                        .multilineTextAlignment(.leading)
                    Text(time)
                        .font(receiverCellTimeFont)
                        .foregroundColor(receiverCellFontColor)
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 10)
                }
            })
            .frame(alignment: .leading)
            .padding(5)
            .background(receiverCellBackgroundColor)
            .cornerRadius(Constants.UIConstants.chatCellCornerRadius)
            .padding(3)
            //
            Spacer()
        })
    }
}

struct ReceiverChatCell_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverChatCell(receiverCellMessageFont: Constants.UIConstants.defaultFont(size: .body), receiverCellHeadingFont: Constants.UIConstants.defaultFont(size: .subHeading), receiverCellTimeFont: Constants.UIConstants.defaultFont(size: .callout), receiverCellFontColor: Constants.UIConstants.charcoalBlack, receiverCellBackgroundColor: Constants.UIConstants.DesertSandColor, chatData: ChatDataModel(message : "Hii This is temp message", userName : "Manni", imageUrl: "", timeStamp: "10:00 am", isMultimediaCell: false, isSender  : false))
            .previewLayout(.sizeThatFits)
    }
}
