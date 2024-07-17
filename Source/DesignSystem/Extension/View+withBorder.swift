import SwiftUI

public extension View {
    func withBorder(
        cornerRadius: CGFloat,
        borderColor: Color,
        borderWidth: CGFloat = 1
    ) -> some View {
        self
            .cornerRadius(cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(
                        borderColor,
                        lineWidth: borderWidth
                    )
            }
    }
}
