//
//  UserList.swift
//  ChatSocketExample
//
//  Created by Valkyrie on 26/08/22.
//

import Foundation
import SwiftUI
import ChatSocket

/// Displays list of friends as Navigation Links.
struct UserList : View {

    // MARK: - Properties
    let friends : [String] = ["Jack", "Diana"]
    @ObservedObject var chatListVM : ChatListVM

    // MARK: - View builder
    var body : some View {
        List(content: {
            ForEach(friends, id: \.self) { friend in
                NavigationLink(friend, destination: {
                    InboxView(titleName: friend, inboxCustomization: chatListVM.getCustomization())
                })
            }
            .listRowSeparator(.visible, edges: .bottom)
            .listRowSeparator(.hidden, edges: .top)
            .listRowSeparatorTint(.gray)
        })
        .listStyle(.plain)
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct UserList_Previews : PreviewProvider {
    static var previews: some View {
        UserList(chatListVM: ChatListVM())
    }
}

