import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth
import FlowKit

struct UserInfo: Equatable{
    var name: String
    var email: String
    var profile: URL
}

struct LoginView: View {
    @Flow var flow
    @AppState var appState
    @State var userInfo: UserInfo?
    @State var isPresent: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Text("왜이러닝")
                .font(WaIronyFontFamily.EliceDXNeolliOTF.bold.swiftUIFont(size: 60))
                .foregroundStyle(Color.Primary.blue20)

            Spacer()

            kakaoLoginButton {
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk { (oauthToken, _) in
                        guard let oauthToken else { return }
                        signin()
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount { (oauthToken, _) in
                        guard let oauthToken else { return }
                        signin()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isPresent) {
            FlowPresenter(
                rootView: InputNameView(
                    name: userInfo!.name,
                    userInfo: userInfo!
                ) {
                    appState.sceneFlow = .tabbar
                    isPresent = false
                }
            )
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
        .onChange(of: userInfo) { userInfo in
            guard let userInfo else { return }
            isPresent = true
//            login(email: userInfo.email) { token in
//                UserDefaults.standard.set(token, forKey: "token")
//                DispatchQueue.main.async {
//                    appState.sceneFlow = .tabbar
//                }
//            }
        }
    }

    func signin() {
        UserApi.shared.me { User, Error in
             guard let name = User?.kakaoAccount?.profile?.nickname,
                   let mail = User?.kakaoAccount?.email,
                   let profile = User?.kakaoAccount?.profile?.profileImageUrl
            else { return }
            self.userInfo = .init(name: name, email: mail, profile: profile)
        }
    }

//    func checkAccount() {
//        guard let url = URL(string: "https://prod-server.xquare.app/scul/users/email") else {
//            print("Error: cannot create URL")
//            return
//        }
//        
//        // Request
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        // Task
//        let defaultSession = URLSession(configuration: .default)
//        
//        defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            guard error == nil else {
//                print("Error occur: error calling GET - \(String(describing: error))")
//                return
//            }
//            
//            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//            
//            guard let output = try? JSONDecoder().decode(NewsListResponseDTO.self, from: data) else {
//                print("Error: JSON data parsing failed")
//                return
//            }
//
//            self.newsList = output.toDomain()
//            
////            completionHandler(true, output.data)
//        }.resume()
//    }

    func login(email: String, completion: @escaping (String) -> Void) {
        let requestDTO = LoginRequestDTO(email: email)
        guard let uploadData = try? JSONEncoder().encode(requestDTO)
        else {return}
        
        let url = URL(string: "https://prod-server.xquare.app/scul/users/login")
        
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

struct LoginRequestDTO: Encodable {
    let email: String
}
