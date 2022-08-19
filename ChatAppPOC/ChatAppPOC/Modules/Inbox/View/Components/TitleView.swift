//
//  TitleView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import SwiftUI


struct TitleView : View {
    //MARK: - Properties
    //Personalization
    var title : String
    var titleFont : Font
    var titleFontColor : Color
    var titleBarBackroundColor : Color
    
    //Closures
    var menuAction : (() -> ())? = nil
    var backAction : (() -> ())? = nil
    var imageAction : (() -> ())? = nil
    
    //Private
    let imageName : String = "line.3.horizontal"
    let personImage : String = "person.crop.circle"
    let backImage : String = "chevron.backward"
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            HStack(alignment: .center, spacing: 5) {
                //Back Button
                Button(action: {
                    if let backAction = backAction {
                        backAction()
                    }
                }, label: {
                    Image(systemName: backImage)
                        .foregroundColor(Constants.UIConstants.charcoalBlack)
                        .font(.title)
                        .frame(width: 34, height: 34, alignment: .center)
                })
                
                //Userimage
                Button(action: {
//                    imageAction()?
                }, label: {
                    Image(systemName: personImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38, alignment: .center)
                        .foregroundColor(Constants.UIConstants.charcoalBlack)
                })
                
                //Title
                Text(title)
                    .foregroundColor(titleFontColor)
                    .font(titleFont).bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.25)
                    .padding(5)
                    .padding(.trailing)
                
                Spacer()
                //Hamburger Menu
                Button(action: {
                    if let menuAction = menuAction {
                        menuAction()
                    }
                }, label: {
                    Image(systemName: imageName)
                        .foregroundColor(Constants.UIConstants.charcoalBlack)
                        .font(.title)
                        .frame(width: 34, height: 34)
                        .padding(5)
                })
            }
            .padding(10)
            Divider()
        })
        .background(titleBarBackroundColor)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: Constants.StringConstants.inboxTitleString, titleFont: Constants.UIConstants.defaultFont(size: .title), titleFontColor: Constants.UIConstants.charcoalBlack, titleBarBackroundColor: Constants.UIConstants.OpalColor)
            .previewLayout(.sizeThatFits)
    }
}

