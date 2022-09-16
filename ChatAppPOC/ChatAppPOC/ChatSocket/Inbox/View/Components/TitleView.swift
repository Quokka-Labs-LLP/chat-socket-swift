//
//  TitleView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import SwiftUI

struct TitleView : View {
    // MARK: - Properties
    // Personalization
    @ObservedObject var inboxViewVM : InboxViewVM

    // Closures
    var menuAction : (() -> Void)?
    var backAction : (() -> Void)?
    var imageAction : (() -> Void)?

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            HStack(alignment: .center, spacing: 5) {
                // Back Button
                Button(action: {
                    if let backAction = backAction {
                        backAction()
                    }
                }, label: {
                    Image(systemName: Constants.SFSymbols.backImage)
                        .foregroundColor(inboxViewVM.titleBackButtonColor)
                        .font(.title)
                        .frame(width: 34, height: 34, alignment: .center)
                })

                // Userimage
                if let image = inboxViewVM.titleBarUserImageUrl {
                    Button(action: {
//                        imageAction()?
                    }, label: {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38, alignment: .center)
                            .foregroundColor(inboxViewVM.titleBackButtonColor)
                    })
                }

                // Title
                Text(inboxViewVM.titleName)
                    .foregroundColor(inboxViewVM.titleFontColor)
                    .font(inboxViewVM.customFont).bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.25)
                    .padding(5)
                    .padding(.trailing)

                Spacer()
                // Hamburger Menu
                Button(action: {
                    if let menuAction = menuAction {
                        menuAction()
                    }
                }, label: {
                    Image(systemName: Constants.SFSymbols.imageName)
                        .foregroundColor(inboxViewVM.titleMenuButtonColor)
                        .font(.title)
                        .frame(width: 34, height: 34)
                        .padding(5)
                })
            }
            .padding(10)
            Divider()
        })
        .background(inboxViewVM.titleBarBackgroundColor)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(inboxViewVM: InboxViewVM(titleName: "titleName", chatSocket: ChatSocket.sharedInstance))
            .previewLayout(.sizeThatFits)
    }
}
