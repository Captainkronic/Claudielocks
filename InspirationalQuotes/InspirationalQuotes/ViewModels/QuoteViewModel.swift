import Foundation
import Combine

final class QuoteViewModel: ObservableObject {
    @Published var currentQuote: Quote
    @Published var showSettings = false
    @Published var showAddQuote = false
    @Published var showRemoveQuotes = false

    let store: QuoteStore
    private var cancellables = Set<AnyCancellable>()
    private var currentIndex: Int = 0

    init(store: QuoteStore = QuoteStore()) {
        self.store = store
        self.currentQuote = store.allQuotes.first ?? PreloadedQuotes.quotes[0]

        // Pick a random starting quote
        let allQuotes = store.allQuotes
        if !allQuotes.isEmpty {
            let idx = Int.random(in: 0..<allQuotes.count)
            self.currentIndex = idx
            self.currentQuote = allQuotes[idx]
        }

        // When quotes list changes, make sure current quote is still valid
        store.$allQuotes
            .sink { [weak self] quotes in
                guard let self else { return }
                if !quotes.contains(where: { $0.id == self.currentQuote.id }) {
                    self.nextQuote()
                }
            }
            .store(in: &cancellables)
    }

    func nextQuote() {
        let quotes = store.allQuotes
        guard quotes.count > 1 else {
            if let first = quotes.first { currentQuote = first }
            return
        }
        // Pick a random different quote
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<quotes.count)
        } while newIndex == currentIndex && quotes.count > 1
        currentIndex = newIndex
        currentQuote = quotes[newIndex]
    }

    func toggleSettings() {
        withAnimationCompat {
            showSettings.toggle()
        }
    }

    func addQuote(text: String, author: String) {
        store.addQuote(text: text, author: author)
    }

    // Helper to use withAnimation from a non-View context
    private func withAnimationCompat(_ body: () -> Void) {
        // This will be called from the view layer with proper animation
        body()
    }
}
