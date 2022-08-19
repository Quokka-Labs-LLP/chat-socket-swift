//
//  ChatDataModel.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation

struct ChatDataModel : Codable, Identifiable {
    // for displaying in list
    var id : UUID = UUID()

    // data
    // let userID      : Int?
    let message     : String?
    let userName    : String?
    let imageUrl    : String?
    let timeStamp   : String?
    let isMultimediaCell : Bool?
    let isSender    : Bool?

}
