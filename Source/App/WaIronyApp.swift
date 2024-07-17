import SwiftUI
import FlowKit

@main
struct WaIronyApp: App {
    init() {
        WaIronyFontFamily.registerAllCustomFonts()
    }
    var body: some Scene {
        WindowGroup {
            FlowPresenter(rootView: LoginView())
        }
    }
}
