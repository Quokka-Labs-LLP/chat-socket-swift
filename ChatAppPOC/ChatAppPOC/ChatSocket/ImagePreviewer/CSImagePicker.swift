//
//  CSImagePicker.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 22/08/22.
//

import Foundation
import SwiftUI
import PhotosUI

struct CSImagePicker : UIViewControllerRepresentable {
    @Binding var image : UIImage?
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var pickerConfiguration = PHPickerConfiguration()
        pickerConfiguration.filter = .images
        let picker = PHPickerViewController(configuration: pickerConfiguration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // - Do nothing
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent : CSImagePicker
        init(_ parent: CSImagePicker ) {
            self.parent = parent
        }
        // MARK: - Delegat methods
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else {return}
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
                    NSLog(error.debugDescription)
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                })
            }
        }
    }
}
