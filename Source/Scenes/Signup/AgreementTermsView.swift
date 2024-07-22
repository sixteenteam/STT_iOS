import SwiftUI
import FlowKit

struct AgreementTermsView: View {
    @State var checkBox = false
    @Environment(\.dismiss) var dismiss
    @AppState var appState
    @Flow var flow
    let userInfo: UserInfo
    let birth: Date
    let navigate: () -> Void
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
                signup { token in
                    UserDefaults.standard.set(token, forKey: "token")
                    DispatchQueue.main.async {
                        navigate()                        
                    }
                }
            }
            .disabled(!checkBox)
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

    func signup(completion: @escaping (String) -> Void) {
        let requestDTO = SignupRequestDTO(email: userInfo.email, name: userInfo.name, birth: birth.toStringFormat("yyyy-MM-dd"), profileImage: userInfo.profile.path())
        guard let uploadData = try? JSONEncoder().encode(requestDTO)
        else {return}
        
        let url = URL(string: "https://prod-server.xquare.app/scul/users/signup")
        
        var request = URLRequest(url: url!)
        // URLRequest 객체를 정의
        request.httpMethod = "POST"
        // HTTP 메시지 헤더
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            
            // 서버가 응답이 없거나 통신이 실패
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            guard let data,
                  let output = try? JSONDecoder().decode(TokenResponseDTO.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output.accessToken)
            // 응답 처리 로직
        }
        // POST 전송
        task.resume()
    }
}

enum AgreementTermType: String {
    case using = "이용약관 동의"
    case privacy = "개인정보 수집 및 이용동의"
}

struct TokenResponseDTO: Decodable {
    let accessToken: String
}

struct SignupRequestDTO: Encodable {
    let email: String
    let name: String
    let birth: String
    let profileImage: String
}
