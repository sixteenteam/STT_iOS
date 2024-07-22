import SwiftUI

struct NewsView: View {
    @State var search = ""
    @State var newsList: [NewsEntity] = []
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("왜이러닝")
                    .font(WaIronyFontFamily.EliceDXNeolliOTF.bold.swiftUIFont(size: 15))
                    .foregroundStyle(Color.Primary.blue20)
                    .padding(.leading, 24)
                    .padding(.vertical, 2)
                
                goToQuiz()
                
                Text("오늘의 경제 뉴스")
                    .waIronyFont(.h3, weight: .bold, color: .black)
                    .padding(.vertical, 7)
                    .padding(.leading, 24)
                
                if let newsFirst = newsList.first {
                    headerNews(news: newsFirst)
                }
                
                Text("지난 경제 뉴스")
                    .waIronyFont(.h5, weight: .bold, color: .black)
                    .padding(.top, 28)
                    .padding(.leading, 24)
                
                Color.GrayScale.gray40
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .padding(.top, 4)
                    .padding(.bottom, 15)
                    .padding(.horizontal, 24)
                
                SearchTextField(text: $search)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)

                VStack(spacing: 16) {
                    if newsList.count > 1 {
                        ForEach(1..<newsList.count, id: \.self) { index in
                            newsCell(news: newsList[index])
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            fetchNewsList()
        }
    }

    func goToQuiz() -> some View {
        HStack(spacing: 9) {
            Text("아직 오늘 퀴즈를 풀지 않으셨네요!")
                .waIronyFont(.caption, weight: .medium, color: .GrayScale.gray90)

            Text("퀴즈 바로가기")
                .waIronyFont(.caption, weight: .medium, color: .Primary.blue40)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.GrayScale.gray30)
    }

    func headerNews(news: NewsEntity) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(news.provider)
                .waIronyFont(.caption, weight: .regular, color: .Primary.blue40)

            Text(news.title)
                .waIronyFont(.body2, weight: .regular, color: .Primary.blue40)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.Sub.blue10)
    }

    func newsCell(news: NewsEntity) -> some View {
        Link(destination: URL(string: news.providerLinkPage)!) {
            VStack(alignment: .leading, spacing: 0) {
                Text(news.provider)
                    .waIronyFont(.body2, weight: .regular, color: .black)

                Text(news.title)
                    .waIronyFont(.body2, weight: .regular, color: .black)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    func fetchNewsList() {
        guard let url = URL(string: "https://prod-server.xquare.app/scul/news/list") else {
            print("Error: cannot create URL")
            return
        }
        
        // Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Task
        let defaultSession = URLSession(configuration: .default)
        
        defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: error calling GET - \(String(describing: error))")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            guard let output = try? JSONDecoder().decode(NewsListResponseDTO.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }

            self.newsList = output.toDomain()
            
            print(output.toDomain())
//            completionHandler(true, output.data)
        }.resume()
    }
}

struct NewsListResponseDTO: Decodable {
    let newsList: [NewsResponseDTO]

    func toDomain() -> [NewsEntity] {
        newsList.map {
            .init(
                id: $0.id,
                title: $0.title,
                provider: $0.provider,
                providerLinkPage: $0.providerLinkPage
            )
        }
    }
}

struct NewsResponseDTO: Decodable {
    let id: Int
    let title: String
    let provider: String
    let providerLinkPage: String
}

struct NewsEntity: Equatable {
    let id: Int
    let title: String
    let provider: String
    let providerLinkPage: String
}

