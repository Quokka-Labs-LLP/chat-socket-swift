//
//  ChatDataModel.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation

public struct ChatDataModel : Codable, Identifiable {
    // for displaying in list
    public var id : UUID = UUID()

//    public let userID           : Int?
    public let message          : String?
    public let userName         : String?
    public let imageUrl         : String?
    public let timeStamp        : String?
    public let isMultimediaCell : Bool?
    public let isSender         : Bool?
}
