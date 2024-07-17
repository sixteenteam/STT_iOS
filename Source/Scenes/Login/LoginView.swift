import SwiftUI
import FlowKit

struct LoginView: View {
    @Flow var flow

    var body: some View {
        VStack {
            Spacer()

            Text("왜이러닝")
                .font(WaIronyFontFamily.EliceDXNeolliOTF.bold.swiftUIFont(size: 60))
                .foregroundStyle(Color.Primary.blue20)

            Spacer()

            kakaoLoginButton {
                flow.fullScreenCover(FlowPresenter(rootView: InputNameView()))
            }
        }
    }

    func kakaoLoginButton(_ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(.kakaoLogo)
                    .resizable()
                    .frame(width: 18, height: 18)

                Spacer()

                Text("카카오 로그인")
                    .font(.custom("AppleSDGothicNeo-SemiBold", size: 16))
                    .foregroundColor(.black.opacity(0.85))

                Spacer()
            }
            .padding(16)
            .background(Color(hexCode: "FEE500"))
            .cornerRadius(6)
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
        }
    }
}
