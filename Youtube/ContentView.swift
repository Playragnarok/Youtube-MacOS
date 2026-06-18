import SwiftUI
import Combine
import WebKit // <-- เพิ่มบรรทัดนี้เข้ามาเพื่อแก้ Error ครับ

struct ContentView: View {
    @StateObject var webViewModel = WebViewModel()
    
    @State private var canGoBack = false
    @State private var canGoForward = false

    var body: some View {
        WebViewWrapper(viewModel: webViewModel)
            .frame(minWidth: 1000, minHeight: 700)
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    
                    // ปุ่มย้อนกลับ
                    Button(action: {
                        webViewModel.webView.goBack()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(!canGoBack)
                    .keyboardShortcut("[", modifiers: .command)
                    .help("ย้อนกลับ (Back)")

                    // ปุ่มไปข้างหน้า
                    Button(action: {
                        webViewModel.webView.goForward()
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(!canGoForward)
                    .keyboardShortcut("]", modifiers: .command)
                    .help("ไปข้างหน้า (Forward)")
                    
                }
            }
            .onReceive(webViewModel.webView.publisher(for: \.canGoBack)) { value in
                self.canGoBack = value
            }
            .onReceive(webViewModel.webView.publisher(for: \.canGoForward)) { value in
                self.canGoForward = value
            }
    }
}
