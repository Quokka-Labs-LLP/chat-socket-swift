//
//  Network.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 02/09/22.
//

import Foundation
import Alamofire
import UIKit

/// Alamofire wrapper class for handling network requests
/// Singleton
class Network {
    // MARK: - Singleton
    static var handler : Network = Network()

    // MARK: - Initializer
    private init() {}

    // MARK: - Public Methods
    func getImageUrl(image: UIImage, imageName: String, completionHandler: (String) -> Void) -> String? {
        // Convert image representation to data
        guard let imageData = image.pngData() else {Log.info(type: .error, message: "Unable to convert image to data"); return nil}

        // upload
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzMDcyYjkyNmY4ZmM1MDZkOTdkNDMwMSIsIm5hbWUiOm51bGwsImlzX29uYm9hcmRlZCI6ZmFsc2UsInByb2ZpbGVfaW1hZ2UiOm51bGwsInByb19tZW1iZXIiOmZhbHNlLCJpYXQiOjE2NjIxMTcxNjh9.R2flePM_1DBwdbsWezsnzbHfqkgBSU6J6UB4IeSymGU"
        let headers : HTTPHeaders = ["AuthorizationToken" : authToken]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: imageName, mimeType: "image/png")
        }, to: "https://devapis.eseosports.com/api/v1/upload-image/chat", method: .post, headers: headers).responseData { result in
            switch result.result {
            case .success(let recievedData) :
                // Decoding
                do {
                    let decodedData = try JSONDecoder().decode(UploadResponse.self, from: recievedData)
                    debugPrint(decodedData)

                } catch(let error) {
                    Log.info(type: .error, message: error.localizedDescription)
                }

            case .failure(let error) :
                print(error)
            }
        }

        // Fall
        return nil
    }

    // Response Model
    struct UploadResponse : Codable {
        let status : Bool?
        let code : Int?
        let message : String?
        let data : WrappedURL?
    }

    struct WrappedURL : Codable {
        let image : String?
    }
}
