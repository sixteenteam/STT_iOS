import SwiftUI

struct MyPageView: View {
    let token: String

    init() {
        self.token = UserDefaults.standard.string(forKey: "token")!
        print(token)
    }

    var body: some View {
        WebView(url: "https://dsm-stt-front-end.vercel.app/mypage/\(token)")
    }
}
