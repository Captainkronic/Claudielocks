import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = QuoteViewModel()

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color(.systemBackground).opacity(0.95),
                    Color.accentColor.opacity(0.05)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Quote card
            QuoteCardView(quote: viewModel.currentQuote) {
                viewModel.nextQuote()
            }

            // Settings cluster — top trailing
            VStack {
                HStack {
                    Spacer()
                    SettingsButtonCluster(
                        isExpanded: $viewModel.showSettings,
                        onAdd: { viewModel.showAddQuote = true },
                        onRemove: { viewModel.showRemoveQuotes = true }
                    )
                }
                Spacer()
            }
            .padding(.top, 16)
            .padding(.trailing, 20)
        }
        .sheet(isPresented: $viewModel.showAddQuote) {
            AddQuoteView { text, author in
                viewModel.addQuote(text: text, author: author)
            }
        }
        .sheet(isPresented: $viewModel.showRemoveQuotes) {
            RemoveQuotesView(store: viewModel.store)
        }
    }
}

#Preview {
    ContentView()
}
