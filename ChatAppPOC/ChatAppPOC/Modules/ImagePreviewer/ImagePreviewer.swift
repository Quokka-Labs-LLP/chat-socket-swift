//
//  ImagePreviewer.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 12/08/22.
//

import Foundation
import SwiftUI

struct ImagePreviewer : View {
    var body: some View {
        Image("demoProfile")
            .resizable()
            .cornerRadius(Constants.UIConstants.standardCornerRadius)
            .padding()
            .frame(width: Constants.UIConstants.screenWidth, height: Constants.UIConstants.screenWidth, alignment: .center)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
    }
}

struct ImagePreviewer_Previews : PreviewProvider {
    static var previews: some View {
        ImagePreviewer()
    }
}
