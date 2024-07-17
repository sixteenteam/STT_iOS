
import SwiftUI

// MARK: - Usage
extension Button {
    func waIronyStyle() -> some View {
        self.buttonStyle(WaIronyButtonStyle())
    }
}

public struct WaIronyButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        AnyView(KGButton(configuration: configuration))
    }
}

// MARK: - green
extension WaIronyButtonStyle {
    struct KGButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool

        var body: some View {
            configuration.label
                .waIronyFont(.body2, weight: .bold, color: .GrayScale.gray10)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(
                    isEnabled ?
                    configuration.isPressed ?
                    Color.Primary.blue40 :
                        Color.Primary.blue20 :
                        Color.GrayScale.gray50
                )
        }
    }
}
