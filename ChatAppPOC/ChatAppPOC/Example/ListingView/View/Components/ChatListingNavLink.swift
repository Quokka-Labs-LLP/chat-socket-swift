//
//  ChatListingNavLink.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 12/09/22.
//

import SwiftUI

struct ChatListingNavLink: View {
    // MARK: - Properties
    /// Navigation Tag
    var friend : String
    var listingViewVM : ListingViewVM
    /// View to move onto

    //MARK: - View Builder
    var body: some View {
        NavigationLink(destination: InboxView(titleName: friend, chatSocket: listingViewVM.getChatSocket()), label: {
            HStack(content: {
                Text(friend)
                    .padding()
                    .font(.headline)
                    .foregroundColor(Constants.UIConstants.charcoalBlack)

                Spacer()
                Image(systemName: "chevron.right")
                    .padding()
                    .foregroundColor(Constants.UIConstants.charcoalBlack)
            })
            .frame(width: Constants.UIConstants.screenWidth - 40, height: 44, alignment: .leading)
            .background(Constants.UIConstants.DesertSandColor   )
            .cornerRadius(Constants.UIConstants.chatCellCornerRadius)
        })
    }
}

struct ChatListingNavLink_Previews: PreviewProvider {
    static var previews: some View {
        ChatListingNavLink(friend: "", listingViewVM: ListingViewVM())
            .previewLayout(.sizeThatFits)
    }
}
