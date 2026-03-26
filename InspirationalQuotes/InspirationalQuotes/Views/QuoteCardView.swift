import SwiftUI

struct QuoteCardView: View {
    let quote: Quote
    let onNext: () -> Void

    @State private var opacity: Double = 1.0

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 20) {
                Text("\u{201C}")
                    .font(.system(size: 64, weight: .ultraLight))
                    .foregroundStyle(.secondary)
                    .offset(y: 10)

                Text(quote.text)
                    .font(.system(size: 24, weight: .light, design: .serif))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 32)

                Text("— \(quote.author)")
                    .font(.system(size: 16, weight: .medium, design: .serif))
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            }
            .opacity(opacity)

            Spacer()

            Button(action: {
                withAnimation(.easeOut(duration: 0.2)) {
                    opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    onNext()
                    withAnimation(.easeIn(duration: 0.3)) {
                        opacity = 1.0
                    }
                }
            }) {
                Image(systemName: "arrow.trianglehead.2.counterclockwise.rotate.90")
                    .font(.system(size: 22))
                    .foregroundStyle(.primary)
                    .frame(width: 56, height: 56)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.bottom, 60)
        }
    }
}
