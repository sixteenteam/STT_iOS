import SwiftUI

struct StockView: View {
    let token: String

    init() {
        self.token = UserDefaults.standard.string(forKey: "token")!
    }

    var body: some View {
        WebView(url: "https://dsm-stt-front-end.vercel.app/stock/\(token)")
    }
}
