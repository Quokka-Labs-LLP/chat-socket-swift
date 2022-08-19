//
//  OnboardingView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 05/08/22.
//

import SwiftUI

struct OnboardingView: View {
    @State var shouldMove = false
    @State var shouldPresentActionSheet = false
    
    let friends : [String] = ["Barak Obama", "Osama Bin Laden"]
    @State var selectedFriend : String = ""
    
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
                            ForEach(friends, id: \.self) { friend in
                                Button(action: {
                                    selectedFriend = friend
                                }, label: {
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
                            }.background {
                                NavigationLink(isActive: $shouldMove, destination: {
                                    InboxView(customization: InboxViewCustomizationModel(titleName: selectedFriend))
                                }, label: {
                                    EmptyView()
                                }).onChange(of: selectedFriend, perform: { sf in
                                    shouldMove = true
                                })
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

extension OnboardingView : InboxViewDelegate {
    func menuButtonTapped() {
        shouldPresentActionSheet = true
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
