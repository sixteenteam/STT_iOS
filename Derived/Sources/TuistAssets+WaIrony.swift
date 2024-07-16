// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum WaIronyAsset {
  public enum Assets {
  }
  public enum GrayScale {
  public static let gray10 = WaIronyColors(name: "Gray 10")
    public static let gray20 = WaIronyColors(name: "Gray 20")
    public static let gray30 = WaIronyColors(name: "Gray 30")
    public static let gray40 = WaIronyColors(name: "Gray 40")
    public static let gray50 = WaIronyColors(name: "Gray 50")
    public static let gray60 = WaIronyColors(name: "Gray 60")
    public static let gray70 = WaIronyColors(name: "Gray 70")
    public static let gray80 = WaIronyColors(name: "Gray 80")
    public static let gray90 = WaIronyColors(name: "Gray 90")
  }
  public enum Primary {
  public static let blue10 = WaIronyColors(name: "Blue 10")
    public static let blue20 = WaIronyColors(name: "Blue 20")
    public static let blue30 = WaIronyColors(name: "Blue 30")
    public static let blue40 = WaIronyColors(name: "Blue 40")
  }
  public enum Sub {
  public static let green10 = WaIronyColors(name: "Green 10")
    public static let green20 = WaIronyColors(name: "Green 20")
    public static let red10 = WaIronyColors(name: "Red 10")
    public static let red20 = WaIronyColors(name: "Red 20")
    public static let skyBlue10 = WaIronyColors(name: "SkyBlue 10")
    public static let skyBlue20 = WaIronyColors(name: "SkyBlue 20")
    public static let yellow10 = WaIronyColors(name: "Yellow 10")
    public static let yellow20 = WaIronyColors(name: "Yellow 20")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class WaIronyColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension WaIronyColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: WaIronyColors) {
    let bundle = WaIronyResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: WaIronyColors) {
    let bundle = WaIronyResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
