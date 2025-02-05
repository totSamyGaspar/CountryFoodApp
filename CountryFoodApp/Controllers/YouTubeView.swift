//
//  YouTubeView.swift
//  CountryFoodApp
//
//  Created by Edward Gasparian on 29.01.2025.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURL = "https://www.youtube.com/embed/\(videoID)"
        if let url = URL(string: embedURL) {
            uiView.load(URLRequest(url: url))
        }
    }
}

