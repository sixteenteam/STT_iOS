import SwiftUI

public struct NavigationBarModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    private let navigationTitle: String

    private let hasBackButton: Bool
    private let backAction: (() -> Void)?
    private let rightIcon: (icon: Image, action: () -> Void)?

    init(
        navigationTitle: String,
        hasBackButton: Bool = false,
        backAction: (() -> Void)?,
        rightIcon: (Image, () -> Void)? = nil
    ) {
        self.navigationTitle = navigationTitle
        self.hasBackButton = hasBackButton
        self.backAction = backAction
        self.rightIcon = rightIcon
    }

    public func body(content: Content) -> some View {
        VStack(spacing: .zero) {
            ZStack(alignment: .topLeading) {
                HStack {
                    if hasBackButton {
                        Button {
                            if let backAction {
                                backAction()
                            } else {
                                dismiss()
                            }
                        } label: {
                            Image(.chevronLeft)
                                .frame(width: 12, height: 28)
                        }
                    }

                    Spacer()

                    if let rightIcon {
                        Button(action: rightIcon.action) {
                            rightIcon.icon
                                .resizable()
                                .frame(width: 28, height: 28)
                        }
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, 24)

                Text(navigationTitle)
                    .waIronyFont(.body1, weight: .medium, color: .black)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.GrayScale.gray10.ignoresSafeArea(edges: .top))

            content
                .frame(maxHeight: .infinity)
        }
        .navigationBarHidden(true)
    }
}

public extension View {
    func navigationBar(
        navigationTitle: String = "",
        hasBackButton: Bool = false,
        backAction: (() -> Void)? = nil,
        rightIcon: (Image, () -> Void)? = nil
    ) -> some View {
        modifier(
            NavigationBarModifier(
                navigationTitle: navigationTitle,
                hasBackButton: hasBackButton,
                backAction: backAction,
                rightIcon: rightIcon
            )
        )
    }

    func navigationBackButton(
        navigationTitle: String = "",
        backAction: (() -> Void)? =  nil
    ) -> some View {
        modifier(
            NavigationBarModifier(
                navigationTitle: navigationTitle,
                hasBackButton: true,
                backAction: backAction
            )
        )
    }
}

// SwipeGesture로 뒤로갈 수 있게 하는 extension
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
