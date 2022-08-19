//
//  View+Extension.swift
//  ChatAppPOC
//
//  Created by Pavnish Kumar Rana on 19/08/22.
//

import Foundation
import SwiftUI

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
