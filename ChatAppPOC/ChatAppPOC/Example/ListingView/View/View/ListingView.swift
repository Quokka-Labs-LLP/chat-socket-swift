//
//  ListingView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 05/08/22.
//

import SwiftUI

struct ListingView: View {

    // MARK: - Properties
    @ObservedObject var listingViewVM : ListingViewVM = ListingViewVM()

    // MARK: - ViewBuilder
    var body: some View {
        NavigationView(content: {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                VStack(content: {
                    //
                    Text("My Chats")
                        .font(.title)
                        .bold()
                        .foregroundColor(Constants.UIConstants.charcoalBlack)

                    // Chat Listing
                    ScrollView {
                        VStack(content: {
                            ForEach(listingViewVM.friends, id: \.self) { friend in
                                ChatListingNavLink(friend: friend, listingViewVM: listingViewVM)
                            }
                        })
                    }
                })

                Text("\"This screen is for Demo Purpose Only.\"")
                    .font(.title)
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding()
            })
            .frame(width: Constants.UIConstants.screenWidth)
            .background(Constants.UIConstants.AlabasterColor)
            .navigationBarHidden(true)

        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
