import SwiftUI
import FlowKit

struct AgreementTermsView: View {
    @State var checkBox = false
    @Flow var flow
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    MultiColoredText(originalText: "왜이러닝에 회원가입하기", coloredSubstrings: [("왜이러닝", .Primary.blue20)])
                        .waIronyFont(.h4, weight: .bold)
                        .padding(.top, 12)
                    
                    Text("이용약관에 동의해주세요")
                        .waIronyFont(.body2, weight: .regular, color: .black)
                }
                
                VStack(spacing: 20) {
                    HStack(spacing: 6) {
                        CheckBox(isOn: $checkBox)
                        
                        Text("전체 동의")
                            .waIronyFont(.body2, weight: .medium, color: .GrayScale.gray90)
                        
                        Spacer()
                    }
                    
                    Color.GrayScale.gray40
                        .frame(maxWidth: .infinity, maxHeight: 1)
                    
                    agreementCell(
                        .using,
                        isChecked: $checkBox
                    )
                    
                    agreementCell(
                        .privacy,
                        isChecked: $checkBox
                    )
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            WaIronyButton(text: "회원가입") {
//                                flow.push()
            }
            .disabled(checkBox)
        }
        .navigationBar(hasBackButton: true)
    }
    
    @ViewBuilder
    func agreementCell(_ type: AgreementTermType, isChecked: Binding<Bool>, isRequired: Bool = true) -> some View {
        HStack(spacing: 6) {
            CheckBox(isOn: isChecked)
            
            HStack(spacing: 0) {
                Text(type.rawValue)
                    .waIronyFont(.body2, weight: .regular, color: .GrayScale.gray90)
                
                if isRequired {
                    Text("(필수)")
                        .waIronyFont(.body2, weight: .regular, color: .Primary.blue20)
                }
            }
            
            Spacer()
            
            Image(.arrowRight)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

enum AgreementTermType: String {
    case using = "이용약관 동의"
    case privacy = "개인정보 수집 및 이용동의"
}
