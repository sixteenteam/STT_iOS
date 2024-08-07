import SwiftUI

public struct SearchTextField: View {
    var placeholder: String
    @Binding var text: String
    var onCommit: () -> Void

    public init(
        _ placeholder: String = "",
        text: Binding<String>,
        onCommit: @escaping () -> Void = {}
    ) {
        self.placeholder = placeholder
        _text = text
        self.onCommit = onCommit
    }

    public var body: some View {
        HStack(spacing: 16) {
            Image(.search)
                .resizable()
                .frame(width: 20, height: 20) 

            ZStack(alignment: .leading) {
                Text(placeholder)
                    .waIronyFont(.caption, weight: .medium, color: .GrayScale.gray60)
                    .opacity(text.isEmpty ? 1 : 0)

                TextField("", text: $text)
                    .waIronyFont(.caption, weight: .medium, color: .black)
                    .onSubmit(onCommit)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 40)
        .background(Color.GrayScale.gray10)
        .withBorder(
            cornerRadius: 8,
            borderColor: .GrayScale.gray50
        )
    }
}
