import SwiftUI
import FlowKit

struct InputProfileView: View {
    @State var uiImage: UIImage?
    @Flow var flow
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    MultiColoredText(originalText: "왜이러닝에 회원가입하기", coloredSubstrings: [("왜이러닝", .Primary.blue20)])
                        .waIronyFont(.h4, weight: .bold)
                        .padding(.top, 12)
                    
                    Text("프로필 사진을 등록해주세요")
                        .waIronyFont(.body2, weight: .regular, color: .black)
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            Group {
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                } else {
                    Image(.defaultProfile)
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            .clipShape(Circle())
            .overlay(alignment: .bottomTrailing) {
                Image(.plus)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(4)
                    .background(Color.Primary.blue20)
                    .clipShape(Circle())
            }
            .onTapGesture {
                flow.sheet(ImagePicker(image: $uiImage).ignoresSafeArea())
            }

            Spacer()

            WaIronyButton(text: "다음") {
                flow.push(AgreementTermsView())
            }
        }
        .navigationBar(hasBackButton: true)
    }
}
