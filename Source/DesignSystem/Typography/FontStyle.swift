import SwiftUI

public enum FontWeight {
    case bold
    case regular
    case medium

    var pretendardFont: WaIronyFontConvertible {
        switch self {
        case .bold:
            WaIronyFontFamily.Pretendard.bold

        case .regular:
            WaIronyFontFamily.Pretendard.regular

        case .medium:
            WaIronyFontFamily.Pretendard.medium
        }
    }
}

public enum FontStyle: Hashable {
    // swiftlint: disable identifier_name
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case body1
    case body2
    case body3
    case caption
    // swiftlint: enable identifier_name

    var size: CGFloat {
        switch self {
        case .h1:
            40
        case .h2:
            36
        case .h3:
            32
        case .h4:
            28
        case .h5:
            24
        case .h6:
            20
        case .body1:
            18
        case .body2:
            16
        case .body3:
            14
        case .caption:
            12
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .h1:
            60
        case .h2:
            54
        case .h3:
            48
        case .h4:
            40
        case .h5:
            36
        case .h6:
            28
        case .body1:
            26
        case .body2:
            24
        case .body3:
            20
        case .caption:
            18
        }
    }
}
