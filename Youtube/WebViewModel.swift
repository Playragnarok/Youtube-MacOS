import SwiftUI
import WebKit
import Combine // <-- เพิ่มบรรทัดนี้เพื่อแก้ไข Error

class WebViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    var webView: WKWebView = WKWebView()

    override init() {
        super.init()
        webView.navigationDelegate = self
        
        // ตั้งค่า User Agent ให้เป็น Safari บน Mac เพื่อให้ YouTube แสดงผลแบบ Desktop สมบูรณ์
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.4 Safari/605.1.15"
        
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
