//
//  ChatTextfield.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import SwiftUI

struct ChatTextfieldView : View {
    //MARK: - Properties
    //State
    @State var textfieldInput : String = Constants.StringConstants.emptyString
    //Personalization
    let textFieldFont : Font
    let textFieldPlaceholderText : String
    let textFieldBackgroundColor : Color
    let textfieldAccentColor : Color
    let textFieldFontColor : Color
    let buttonColor : Color
    let mainBackground : Color
    
    //Closure
    let chatButtonAction : (String) -> ()
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(alignment: .center, spacing: 10, content: {
                TextField(textFieldPlaceholderText, text: $textfieldInput)
                    .frame(height: 34)
                    .font(textFieldFont)
                    .padding(.horizontal, 10)
                    .background(textFieldBackgroundColor)
                    .accentColor(textfieldAccentColor)
                    .foregroundColor(textFieldFontColor)
                    .cornerRadius(Constants.UIConstants.textFieldCornerRadius)
                    .shadow(color: Constants.UIConstants.charcoalBlack.opacity(0.3), radius: 2, x: 0, y: 0)
                    
                    
                Button(action: {
                    chatButtonAction(textfieldInput)
                    textfieldInput = Constants.StringConstants.emptyString
                }, label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 34, height: 34, alignment: .center)
                        .foregroundColor(buttonColor)
                        .shadow(color: Constants.UIConstants.charcoalBlack.opacity(0.3), radius: 2, x: 0, y: 0)
                })
                
            })
            .padding()
        }.background(mainBackground)
    }
}


struct ChatTextfieldView_Previews : PreviewProvider {
    static var previews: some View {
        ChatTextfieldView(textFieldFont: Constants.UIConstants.defaultFont(size: .body), textFieldPlaceholderText: Constants.StringConstants.defaultPlaceholder, textFieldBackgroundColor: Constants.UIConstants.alabasterColor, textfieldAccentColor: Constants.UIConstants.desertSandColor, textFieldFontColor: Constants.UIConstants.charcoalBlack, buttonColor: Constants.UIConstants.charcoalBlack, mainBackground: Constants.UIConstants.opalColor, chatButtonAction: { _ in
            // send tapped
        })
            .previewLayout(.sizeThatFits)
    }
}

