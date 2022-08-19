//
//  SenderMultimediaChatCell.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import SwiftUI

struct SenderMultimediaChatCell: View {
    //MARK: - Properties
    //Customization
    let senderShouldShowHeading     : Bool
    let senderCellMessageFont       : Font
    let senderCellHeadingFont       : Font
    let senderCellTimeFont          : Font
    let senderCellFontColor         : Color
    let senderCellBackgroundColor   : Color
    
    //Data
    let chatData : ChatDataModel
    //private
    private let alignment : HorizontalAlignment = .trailing
    
    //MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Spacer()
            VStack(alignment: .trailing, spacing: 5, content: {
                //Head
                if let userName = chatData.userName, senderShouldShowHeading {
                    Text(userName)
                        .foregroundColor(senderCellFontColor)
                        .font(senderCellHeadingFont)
                        .bold()
                }
                
                // message body
                if let message = chatData.message, let time = chatData.timeStamp {
                    if let image = chatData.imageUrl {
                        // set image using url
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: Constants.UIConstants.screenWidth - 100, height: Constants.UIConstants.screenWidth - 200, alignment: .center)
                            .cornerRadius(Constants.UIConstants.standardCornerRadius)
                            .padding(5)
                    }
                    
                    Text(message)
                        .foregroundColor(senderCellFontColor)
                        .font(senderCellMessageFont)
                        .multilineTextAlignment(.leading)
                    
                    Text(time)
                        .foregroundColor(senderCellFontColor)
                        .font(senderCellTimeFont)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                }
                
            })
            .frame(alignment: .trailing)
            .padding(5)
            .background(senderCellBackgroundColor)
            .cornerRadius(Constants.UIConstants.chatCellCornerRadius)
            .padding(3)
        })
    }
}

struct SenderMultimediaChatCell_Previews: PreviewProvider {
    static var previews: some View {
        SenderMultimediaChatCell(senderShouldShowHeading: false, senderCellMessageFont: Constants.UIConstants.defaultFont(size: .body), senderCellHeadingFont: Constants.UIConstants.defaultFont(size: .subHeading), senderCellTimeFont: Constants.UIConstants.defaultFont(size: .callout), senderCellFontColor: Constants.UIConstants.charcoalBlack, senderCellBackgroundColor: Constants.UIConstants.DesertSandColor, chatData: ChatDataModel(message: "Hello World", userName: "Manni", imageUrl: "demoMessageImage", timeStamp: "10:00 AM", isMultimediaCell: nil, isSender: true))
            .previewLayout(.sizeThatFits)
    }
}
