//
//  ChatDataModel.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation

public struct ChatDataModel: Codable, Identifiable {
    // for displaying in list
    public var id: UUID = UUID()

    // data
    public let message: String?
    public let userName: String?
    public let imageUrl: String?
    public let timeStamp: String?
    public let isSender: Bool?
}
