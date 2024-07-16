import SwiftUI

public struct WaIronyFont: ViewModifier {
    public let style: FontStyle
    public var weight: FontWeight
    private let lineHeight: CGFloat

    init(style: FontStyle, weight: FontWeight) {
        self.style = style
        self.weight = weight
        self.lineHeight = weight.pretendardFont.font(size: style.size).lineHeight
    }

    public func body(content: Content) -> some View {
        content
            .font(weight.pretendardFont.swiftUIFont(size: style.size))
            .lineSpacing(style.lineHeight - lineHeight)
            .padding(.vertical, (style.lineHeight - lineHeight) / 2)
    }
}

public extension View {
    func waIronyFont(_ style: FontStyle, weight: FontWeight) -> some View {
        self
            .modifier(WaIronyFont(style: style, weight: weight))
    }

    func waIronyFont(_ style: FontStyle, weight: FontWeight, color: Color) -> some View {
        self
            .waIronyFont(style, weight: weight)
            .foregroundColor(color)
    }
}
