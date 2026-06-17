import SwiftUI
import WebKit
import Combine

class WebViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    var webView: WKWebView

    override init() {
        // 1. สร้างชุดการตั้งค่า (Configuration) เพื่ออนุญาตการดูแบบ Full Screen
        let configuration = WKWebViewConfiguration()
        let preferences = WKPreferences()
        
        // เปิดอนุญาต HTML5 Fullscreen (รองรับตั้งแต่ macOS 12.1 เป็นต้นไป)
        if #available(macOS 12.1, *) {
            preferences.isElementFullscreenEnabled = true
        } else {
            // โค้ดสำรองสำหรับ macOS เวอร์ชันเก่า
            preferences.setValue(true, forKey: "fullScreenEnabled")
        }
        
        configuration.preferences = preferences
        
        // 2. นำการตั้งค่ามาใส่ในตอนเริ่มสร้าง WebView
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        
        super.init()
        
        self.webView.navigationDelegate = self
        
        // ตั้งค่า User Agent ให้เป็น Safari บน Mac
        self.webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.4 Safari/605.1.15"
        
        load(url: "https://www.youtube.com")
    }

    func load(url: String) {
        if let validURL = URL(string: url) {
            webView.load(URLRequest(url: validURL))
        }
    }
}

// ตัวหุ้ม WKWebView เพื่อให้ใช้งานร่วมกับ SwiftUI ได้
struct WebViewWrapper: NSViewRepresentable {
    @ObservedObject var viewModel: WebViewModel

    func makeNSView(context: Context) -> WKWebView {
        return viewModel.webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // ไม่ต้องอัปเดตอะไรเพิ่มเติม
    }
}
