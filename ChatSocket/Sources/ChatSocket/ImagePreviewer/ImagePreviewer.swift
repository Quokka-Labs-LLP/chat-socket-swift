//
//  ImagePreviewer.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 12/08/22.
//

import Foundation
import SwiftUI

struct ImagePreviewer : View {

    let image : Image
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // TitleBar
                HStack {
                    Button(action: {
                        mode.projectedValue.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: Constants.SFSymbols.backImage)
                            .foregroundColor(Constants.UIConstants.charcoalBlack)
                            .font(.title)
                            .frame(width: 34, height: 34, alignment: .center)
                    })
                    Spacer()
                }.padding(10)

                // Image
                ZoomableScrollView(content: {
                    image
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: Constants.UIConstants.screenWidth, alignment: .center)
                })
            }
        }

    }
}

struct ImagePreviewer_Previews : PreviewProvider {
    static var previews: some View {
        ImagePreviewer(image: Image("demoProfile"))
            .fixedSize()
    }
}
