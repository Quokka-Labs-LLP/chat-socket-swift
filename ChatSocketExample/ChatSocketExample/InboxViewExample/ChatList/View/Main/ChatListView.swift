//
//  ChatListView.swift
//  ChatSocketExample
//
//  Created by Valkyrie on 25/08/22.
//

import SwiftUI
import ChatSocket

struct ChatListView: View {

    // MARK: - properties
    @ObservedObject var chatListVM : ChatListVM = ChatListVM()

    // MARK: - View builder
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                TitleView(title: StringConstants.chatList)
                UserList(chatListVM: chatListVM)
            })
            .navigationBarHidden(true)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
