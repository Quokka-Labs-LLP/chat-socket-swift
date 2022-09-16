//
//  ZoomableScrollView.swift
//  ChatAppPOC
//
//  Created by Valkyrie on 24/08/22.
//

import Foundation
import SwiftUI
import UIKit

/// Add zoom and scroll functionality in provided content. e.g. - Image
/// - Implementation
///     - Provide frame to image.
///     - Make image resizable.
///     - Set aspect ratio to fit.
struct ZoomableScrollView <Content : View> : UIViewRepresentable {
   // MARK: - Properties
    private var content : Content

    // MARK: - Initializer
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    // MARK: - Scroll View
    func makeUIView(context: Context) -> some UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true

        if let hostedView = context.coordinator.hostingController.view {
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            hostedView.frame = scrollView.bounds

            scrollView.addSubview(hostedView)
        }

        return scrollView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }

    class Coordinator : NSObject, UIScrollViewDelegate {
        var hostingController : UIHostingController<Content>

        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}
