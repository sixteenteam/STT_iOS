import SwiftUI
import FlowKit

struct InputNameView: View {
    @State var name: String = ""
    @Flow var flow
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    MultiColoredText(originalText: "왜이러닝에 회원가입하기", coloredSubstrings: [("왜이러닝", .Primary.blue20)])
                        .waIronyFont(.h4, weight: .bold)
                        .padding(.top, 56)
                    
                    Text("이름을 입력해주세요")
                        .waIronyFont(.body2, weight: .regular, color: .black)
                }
                
                WaIronyTextField("이름을 입력해주세요.", text: $name)
            }
            .padding(.horizontal, 24)

            Spacer()

            WaIronyButton(text: "다음") {
                flow.push(InputBirthView())
            }
            .disabled(name.isEmpty)
        }
        .navigationBarHidden(true)
    }
}
