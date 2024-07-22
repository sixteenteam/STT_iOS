import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import FlowKit

@main
struct WaIronyApp: App {
    @ObservedObject var appState = AppStateProvider(sceneFlow: .auth)

    init() {
        WaIronyFontFamily.registerAllCustomFonts()
        KakaoSDK.initSDK(appKey: "8b1eb3333e8a1d93691ada9540ad6af6")
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
