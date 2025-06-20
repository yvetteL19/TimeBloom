import SwiftUI
import WebKit

// This is a custom view that can play GIF images.
// It wraps UIKit's WKWebView, which can render GIFs.
struct GIFView: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // This is the crucial part for loading local files correctly.
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("Error: GIF file '\(name).gif' not found in project.")
            return webView
        }
        
        // Make the web view's background transparent and disable scrolling.
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        
        // We load the raw data and provide the base URL of the resource directory.
        // This is a more robust way to load local content.
        do {
            let data = try Data(contentsOf: url)
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingLastPathComponent()
            )
        } catch {
            print("Error loading GIF data: \(error)")
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No update needed for this use case.
    }
}
