import SwiftUI
import UIKit

struct TabBarView: View {
    @State var selection: TabFlow = .news
    @State var tabbarHidden = false

    var tabItem: [(Image, String, TabFlow)] = [
        (.init(.news), "뉴스", .news),
        (.init(.quiz), "퀴즈", .quiz),
        (.init(.stock), "모의투자", .stock),
        (.init(.myPage), "마이페이지", .myPage)
    ]

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selection) {
                NewsView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(TabFlow.news)

                QuizView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(TabFlow.quiz)

                StockView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(TabFlow.stock)

                MyPageView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(TabFlow.myPage)
            }
            .frame(maxHeight: .infinity)
            .environment(\.tabbarHidden, $tabbarHidden)

            if !tabbarHidden {
                Color.GrayScale.gray30
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                tabbarView()
                    .background {
                        Color.GrayScale.gray10
                            .ignoresSafeArea()
                    }
            }
        }
        .navigationBarHidden(true)
    }

    @ViewBuilder
    func tabbarView() -> some View {
        HStack {
            Spacer()

            ForEach(tabItem, id: \.1) { image, title, tag in
                tabItemView(image: image, title: title, tag: tag)
                    .frame(width: 56, height: 44)
                    .padding(.vertical, 4)

                Spacer()
            }
        }
    }

    @ViewBuilder
    func tabItemView(image: Image, title: String, tag: TabFlow) -> some View {
        Button {
            withAnimation {
                self.selection = tag
            }
        } label: {
            VStack(spacing: 0) {
                image
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(selection == tag ? .GrayScale.gray90 : .GrayScale.gray50)

                Text(title)
                    .waIronyFont(.caption, weight: .medium, color: selection == tag ? .GrayScale.gray90 : .GrayScale.gray50)
            }
        }
    }
}
