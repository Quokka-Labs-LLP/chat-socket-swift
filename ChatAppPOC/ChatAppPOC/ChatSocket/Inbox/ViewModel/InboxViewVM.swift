//
//  InputViewVM.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 04/08/22.
//

import Foundation
import SwiftUI
import SocketIO

class InboxViewVM : ObservableObject {

    // MARK: - Properties
    var socketManager : SocketManager?
    var socket : SocketIOClient?

    // Published
    @Published var shouldPresentActionSheet : Bool = false
    @Published var shouldPresentImagePicker : Bool = false
    @Published var chatMessages : [ChatDataModel] = []
    @Published var pickedImage : UIImage? {
        didSet {
            if let image = pickedImage {
                // getImageUrl(image)
                Network.handler.getImageUrl(image: image, imageName: "image", completionHandler: { url in
                    print(url)
                })
            }
        }
    }

    var chatSocket : ChatSocket?

    // Customization options and default values
    // TITLE VIEW
    let titleName: String
    let customFont: Font
    let titleFontColor: Color
    let titleBarBackgroundColor : Color
    let titleBackButtonColor    : Color
    let titleMenuButtonColor    : Color
    let titleBarUserImageUrl    : String?

    // CHAT CELL
    // - Sender
    let senderShouldShowHeading: Bool
    let senderCellMessageFont: Font
    let senderCellHeadingFont: Font
    let senderCellTimeFont: Font
    let senderCellFontColor: Color
    let senderCellBackgroundColor: Color

    // - Receiver
    let receiverCellMessageFont: Font
    let receiverCellHeadingFont: Font
    let receiverCellTimeFont: Font
    let receiverCellFontColor: Color
    let receiverCellBackgroundColor: Color

    // CHAT TEXTFIELD VIEW
    let textFieldFont: Font
    let textFieldPlaceholderText: String
    let textFieldBackgroundColor: Color
    let textfieldAccentColor: Color
    let textFieldFontColor: Color
    let buttonColor: Color
    let mainBackground: Color

    // MAIN
    let mainBackgroundColor : Color

    // MARK: - initializer
    init(titleName : String, chatSocket : ChatSocket, inboxCustomization : InboxViewCustomizationModel? = nil) {
        // - title view
        self.titleName = titleName
        self.customFont = inboxCustomization?.titleFont ?? Constants.UIConstants.defaultFont(size: .title)
        self.titleFontColor = inboxCustomization?.titleFontColor ?? Constants.UIConstants.charcoalBlack
        self.titleBarBackgroundColor = inboxCustomization?.titleBarBackgroundColor ?? Constants.UIConstants.OpalColor
        self.titleBackButtonColor    = inboxCustomization?.titleBackButtonColor ?? Constants.UIConstants.charcoalBlack
        self.titleMenuButtonColor    = inboxCustomization?.titleMenuButtonColor ?? Constants.UIConstants.charcoalBlack
        self.titleBarUserImageUrl    = inboxCustomization?.titleUserImageUrl

        // - sender cell
        self.senderShouldShowHeading = inboxCustomization?.senderShouldShowHeading ?? false
        self.senderCellMessageFont = inboxCustomization?.senderCellMessageFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.senderCellHeadingFont = inboxCustomization?.senderCellHeadingFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.senderCellTimeFont = inboxCustomization?.senderCellTimeFont ?? Constants.UIConstants.defaultFont(size: .callout)
        self.senderCellFontColor = inboxCustomization?.senderCellFontColor ?? Constants.UIConstants.charcoalBlack
        self.senderCellBackgroundColor = inboxCustomization?.senderCellBackgroundColor ?? Constants.UIConstants.DesertSandColor

        // receiver cell
        self.receiverCellMessageFont = inboxCustomization?.receiverCellMessageFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.receiverCellHeadingFont = inboxCustomization?.receiverHeadingFont ?? Constants.UIConstants.defaultFont(size: .subHeading)
        self.receiverCellTimeFont = inboxCustomization?.receiverCellTimeFont ?? Constants.UIConstants.defaultFont(size: .callout)
        self.receiverCellFontColor = inboxCustomization?.receiverFontCellColor ?? Constants.UIConstants.charcoalBlack
        self.receiverCellBackgroundColor = inboxCustomization?.receiverCellBackgroundColor ?? Constants.UIConstants.DesertSandColor

        // Chat textfield
        self.textFieldFont = inboxCustomization?.textFieldFont ?? Constants.UIConstants.defaultFont(size: .body)
        self.textFieldPlaceholderText = inboxCustomization?.textFieldPlaceholderText ?? Constants.StringConstants.defaultPlaceholder
        self.textFieldBackgroundColor = inboxCustomization?.textFieldBackgroundColor ?? Constants.UIConstants.AlabasterColor
        self.textfieldAccentColor = inboxCustomization?.textfieldAccentColor ?? Constants.UIConstants.DesertSandColor
        self.textFieldFontColor = inboxCustomization?.textFieldFontColor ?? Constants.UIConstants.charcoalBlack
        self.buttonColor = inboxCustomization?.textFieldSendbuttonColor ?? Constants.UIConstants.charcoalBlack
        self.mainBackground = inboxCustomization?.textFieldContainerMainBackgroundColor ?? Constants.UIConstants.OpalColor

        // MAIN
        self.mainBackgroundColor = inboxCustomization?.mainBackgroundColor ?? Constants.UIConstants.AlabasterColor
        self.chatSocket = chatSocket
    }

    // MARK: - Public methods
    func connect() {
        if isChatSocketAssigned() {
            chatSocket?.connect(onMessageReceiveEvent: { responseMessage, _  in
                self.chatMessages.append(ChatDataModel(message: responseMessage, userName: "User", imageUrl: "", timeStamp: self.getCurrentTime(), isMultimediaCell: nil, isSender: false))
            })
        }

    }

    func sendMessage(text: String) {
        if isChatSocketAssigned() {

            let chatData = ChatDataModel(message: text, userName: "Manni", imageUrl: nil, timeStamp: getCurrentTime(), isMultimediaCell: nil, isSender: true)

            chatMessages.append(chatData)

            chatSocket?.sendMessage(chatData)
        }
    }

    func sendMultimediaMessage(imageUrl: String) {
        if isChatSocketAssigned() {
            chatMessages.append(ChatDataModel(message: nil, userName: "Manni", imageUrl: imageUrl, timeStamp: getCurrentTime(), isMultimediaCell: nil, isSender: true))
            chatSocket?.sendMultimediaMessage(imageUrl)
        }
    }

    struct UploadResponse : Codable {
        let status : Bool?
        let code : Int?
        let message : String?
        let data : WrappedURL?
    }

    struct WrappedURL : Codable {
        let image : String?
    }

    // will be executed as soon as user picks an image
    func getImageUrl(_ image: UIImage) {

        let key = "image"

        let url = URL(string: "https://devapis.eseosports.com/api/v1/upload-image/chat")!

        print("req from url")
        let boundary = UUID().uuidString
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzMDcyYjkyNmY4ZmM1MDZkOTdkNDMwMSIsIm5hbWUiOm51bGwsImlzX29uYm9hcmRlZCI6ZmFsc2UsInByb2ZpbGVfaW1hZ2UiOm51bGwsInByb19tZW1iZXIiOmZhbHNlLCJpYXQiOjE2NjIxMTcxNjh9.R2flePM_1DBwdbsWezsnzbHfqkgBSU6J6UB4IeSymGU"

        request.setValue(authToken, forHTTPHeaderField: "AuthorizationToken")

        var data = Data()

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\(key); filename=valkyrie.jpg\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(image.jpegData(compressionQuality: 1.0)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        session.uploadTask(with: request, from: data) { receivedData, urlResponse, error in
            do {

                guard let receivedData = receivedData else {
                    return
                }

                let decodedData = try JSONDecoder().decode(UploadResponse.self, from: receivedData)

                print(decodedData)

            } catch(let error) {
                NSLog(error.localizedDescription)
            }
        }.resume()
    }


    // MARK: - private methods
    private func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringConstants.timeFormat
        let date = dateFormatter.string(from: Date())

        return eliminateZeroFromTime(timeString: date)
    }

    /// Socket not initialized Validation
    /// - Returns: returns if the chat socket is initialised or not
    private func isChatSocketAssigned() -> Bool {
        if chatSocket != nil {
            return true
        } else {
            Log.info(type: .error, message: Constants.StringConstants.chatSocketNotAssigned)
            return false
        }
    }

    // Timestamp
    private func getCurrentTimeStamp() -> Int {
        let timeStamp = Date().timeIntervalSince1970
        return Int(timeStamp) // will always be 10 Digits
    }

    private func resolveTimeStamp(_ timeStamp: Int) -> String {
        let timeInterval = TimeInterval(timeStamp)
        let rawDateinGMT = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringConstants.timeFormat
        let formattedDate = dateFormatter.string(from: rawDateinGMT as Date)

        return formattedDate
    }

    func eliminateZeroFromTime(timeString: String ) -> String {
        var time = timeString

        if time.first == "0" {
            time.remove(at: time.startIndex)
        }

        return time
    }
}
