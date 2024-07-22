import SwiftUI
import FlowKit

struct ResolvedQuizListView: View {
    @Flow var flow
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 6) {
                    Text("이전 퀴즈 기록")
                        .waIronyFont(.h3, weight: .bold, color: .black)
                    
                    Text("150")
                        .waIronyFont(.caption, weight: .medium, color: .white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 12)
                        .background(Color.Primary.blue20)
                        .cornerRadius(20)
                    
                    Spacer()
                }
                .padding(.top, 12)
                
                Text("2024년 3월 4일")
                    .waIronyFont(.body3, weight: .bold, color: .black)
                
                VStack(spacing: 8) {
                    ForEach(0..<5) { _ in
                        detailCell()
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBar(hasBackButton: true)
    }

    func detailCell() -> some View {
        HStack(spacing: 8) {
            Text("Q.")
                .waIronyFont(.h3, weight: .bold, color: .Primary.blue20)

            Text("증시에서 거래가 얼마나 활발한지 보여주는 지표다. 일정 기간의 거래량을 상장주식 수로 나눈 값은?")
                .waIronyFont(.caption, weight: .regular, color: .black)

            Spacer()

            Image(.navigationArrow)
                .resizable()
                .frame(width: 16, height: 16)
        }
        .padding(.vertical, 7)
    }
}
