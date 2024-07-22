import SwiftUI

@propertyWrapper
struct AppState: DynamicProperty {
    @EnvironmentObject private var object: AppStateProvider

    var wrappedValue: AppStateProvider {
        object
    }

    public init() { }
}

final class AppStateProvider: ObservableObject {
    @Published var sceneFlow: SceneFlow

    init(sceneFlow: SceneFlow) {
        self.sceneFlow = sceneFlow
    }
}

enum SceneFlow: String, RawRepresentable {
    case auth
    case tabbar
}
