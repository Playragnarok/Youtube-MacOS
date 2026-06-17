import SwiftUI

struct ContentView: View {
    @StateObject var webViewModel = WebViewModel()

    var body: some View {
        WebViewWrapper(viewModel: webViewModel)
            // กำหนดขนาดหน้าต่างเริ่มต้นของแอป
            .frame(minWidth: 1000, minHeight: 700)
    }
}
