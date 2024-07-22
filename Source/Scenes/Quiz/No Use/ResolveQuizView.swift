import SwiftUI
import FlowKit

struct ResolveQuizView: View {
    @Flow var flow
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 6) {
                Text("경제 퀴즈")
                    .waIronyFont(.h3, weight: .bold, color: .black)

                Text("1/5")
                    .waIronyFont(.caption, weight: .medium, color: .white)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 12)
                    .background(Color.Primary.blue20)
                    .cornerRadius(20)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 56)

            Text("Q.")
                .waIronyFont(.h3, weight: .bold, color: .Primary.blue20)
                .padding(.top, 8)
                .padding(.bottom, 2)
                .padding(.horizontal, 24)

            Text("증시에서 거래가 얼마나 활발한지 보여주는 지표다. 일정 기간의 거래량을 상장주식 수로 나눈 값은?")
                .waIronyFont(.body1, weight: .medium, color: .black)
                .padding(.bottom, 8)
                .padding(.horizontal, 24)

            VStack(spacing: 16) {
                choiceCell("주가수익비율")

                choiceCell("주가수익비율")

                choiceCell("주가수익비율")

                choiceCell("주가수익비율")
            }
            .padding(.horizontal, 24)

            Spacer()

            Button {
                flow.push(ResolvedQuizListView())
            } label: {
                Text("이미 푼 문제 보러가기")
                    .waIronyFont(.caption, weight: .medium, color: .GrayScale.gray60)
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            WaIronyButton(text: "정답확인하기")
        }
    }

    func choiceCell(_ text: String) -> some View {
        Text(text)
            .waIronyFont(.caption, weight: .medium, color: .GrayScale.gray60)
            .padding(.vertical, 7)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .withBorder(cornerRadius: 4, borderColor: .GrayScale.gray40)
    }
}
