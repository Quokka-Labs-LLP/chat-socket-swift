//
//  ChatTextfield.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import SwiftUI
import PhotosUI
import Photos

struct ChatTextfieldView : View {
    // MARK: - Properties
    // State
    @State var textfieldInput : String = Constants.StringConstants.emptyString
    @ObservedObject var inboxViewVM : InboxViewVM

    @State var shouldShowUploadImage : Bool = true

    // Closure
    let chatButtonAction : (String) -> Void

    // MARK: - Body
    var body: some View {

        let bindingTextFieldValue = Binding <String>(get: {
            self.textfieldInput
        }, set: {
            self.textfieldInput = $0
            withAnimation(.easeInOut(duration: 0.2)) {
                self.shouldShowUploadImage = self.textfieldInput.isEmpty
            }
        })

        VStack(spacing: 0) {
            Divider()
            HStack(alignment: .center, spacing: 10, content: {
                // Textfield
                TextField(inboxViewVM.textFieldPlaceholderText, text: bindingTextFieldValue)
                    .frame(height: 34)
                    .font(inboxViewVM.textFieldFont)
                    .padding(.horizontal, 10)
                    .background(inboxViewVM.textFieldBackgroundColor)
                    .accentColor(inboxViewVM.textfieldAccentColor)
                    .foregroundColor(inboxViewVM.textFieldFontColor)
                    .cornerRadius(Constants.UIConstants.textFieldCornerRadius)
                    .shadow(color: Constants.UIConstants.charcoalBlack.opacity(0.3), radius: 2, x: 0, y: 0)

                // Image Upload button
                if shouldShowUploadImage {
                    Button(action: {
                        inboxViewVM.shouldPresentImagePicker.toggle()
                    }, label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34, height: 34, alignment: .center)
                            .foregroundColor(inboxViewVM.buttonColor)
                            .shadow(color: Constants.UIConstants.charcoalBlack.opacity(0.3), radius: 2, x: 0, y: 0)
                    }).sheet(isPresented: $inboxViewVM.shouldPresentImagePicker, content: {
                        CSImagePicker(image: $inboxViewVM.pickedImage)
                    })

                }

                // enable/disable on textfield type
                Button(action: {
                    chatButtonAction(textfieldInput)
                    textfieldInput = Constants.StringConstants.emptyString
                }, label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 34, height: 34, alignment: .center)
                        .foregroundColor(inboxViewVM.buttonColor)

                })
                .disabled(textfieldInput == "" ? true : false)
                .opacity(textfieldInput == "" ? 0.8 : 1.0)
                .shadow(color: Constants.UIConstants.charcoalBlack.opacity(textfieldInput == "" ? 0.0 : 0.3), radius: 2, x: 0, y: 0)

            })
            .padding()
        }.background(inboxViewVM.mainBackground)
    }
}

struct ChatTextfieldView_Previews : PreviewProvider {
    static var previews: some View {
        ChatTextfieldView(inboxViewVM: InboxViewVM(titleName: "titleName", chatSocket: ChatSocket.sharedInstance, inboxCustomization: InboxViewCustomizationModel()), chatButtonAction: { _ in
            // send tapped
        })
            .previewLayout(.sizeThatFits)
    }
}
