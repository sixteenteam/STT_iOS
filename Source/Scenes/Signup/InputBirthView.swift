import SwiftUI
import FlowKit

struct InputBirthView: View {
    @State var birth: String = ""
    @Flow var flow
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    MultiColoredText(originalText: "왜이러닝에 회원가입하기", coloredSubstrings: [("왜이러닝", .Primary.blue20)])
                        .waIronyFont(.h4, weight: .bold)
                        .padding(.top, 12)
                    
                    Text("생년월일을 입력해주세요")
                        .waIronyFont(.body2, weight: .regular, color: .black)
                }
                
                WaIronyTextField("ex ) 2024-04-04", text: $birth)
            }
            .padding(.horizontal, 24)

            Spacer()

            WaIronyButton(text: "다음") {
                flow.push(InputProfileView())
            }
            .disabled(birth.isEmpty)
        }
        .navigationBar(hasBackButton: true)
    }
}
