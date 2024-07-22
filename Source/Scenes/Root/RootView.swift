import SwiftUI
import FlowKit

struct RootView: View {
    @AppState var appState
    var body: some View {
        ZStack {
            switch appState.sceneFlow {
            case .auth:
                FlowPresenter(rootView: LoginView())
                    .environmentObject(appState)
                
            case .tabbar:
                FlowPresenter(rootView: TabBarView())
                    .environmentObject(appState)
            }
        }
        .animation(.easeInOut, value: appState.sceneFlow)
        .transition(.opacity.animation(.easeInOut))
    }
}
