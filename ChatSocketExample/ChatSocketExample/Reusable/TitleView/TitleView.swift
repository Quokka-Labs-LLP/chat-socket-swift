//
//  TitleView.swift
//  ChatSocketExample
//
//  Created by Valkyrie on 26/08/22.
//

import Foundation
import SwiftUI

struct TitleView : View {
    // MARK: - Properties
    let title : String

    // MARK: - View Builder
    var body: some View {
        VStack (content: {
            HStack(content: {
                Text(title)
                    .font(Font.custom(StringConstants.fontMontserratLight, size: 20))
                    .foregroundColor(.red)
            })
            Divider().frame(width: UIConstants.screenWidth)
        })
        .frame(width: UIConstants.screenWidth, height: UIConstants.navigationBarHeight, alignment: .center)
        .padding(.top).shadow(radius: UIConstants.defaultShadowRadius)
    }
}

// MARK: - preview
struct TitleView_Previews : PreviewProvider {
    static var previews : some View {
        TitleView(title: PreviewConstants.Strings.title)
            .previewLayout(.sizeThatFits)
    }
}
