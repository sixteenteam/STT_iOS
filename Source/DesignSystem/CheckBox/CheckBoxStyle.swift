import SwiftUI

struct CheckboxStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled: Bool

    public func makeBody(configuration: Self.Configuration) -> some View {
        Image(configuration.isOn ? .checkYES : .checkNO)
            .resizable()
            .frame(width: 24, height: 24)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.1)) {
                    configuration.isOn.toggle()
                }
            }
    }
}
