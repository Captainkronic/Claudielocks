import Foundation

final class QuoteStore: ObservableObject {
    private static let userQuotesKey = "userQuotes"

    @Published private(set) var allQuotes: [Quote] = []
    @Published private(set) var userQuotes: [Quote] = []

    init() {
        loadQuotes()
    }

    // MARK: - Public

    var currentQuotes: [Quote] {
        allQuotes
    }

    func addQuote(text: String, author: String) {
        let quote = Quote(text: text, author: author, isPreloaded: false)
        userQuotes.append(quote)
        rebuildAllQuotes()
        saveUserQuotes()
    }

    func deleteUserQuote(at offsets: IndexSet) {
        userQuotes.remove(atOffsets: offsets)
        rebuildAllQuotes()
        saveUserQuotes()
    }

    func deleteUserQuote(_ quote: Quote) {
        guard !quote.isPreloaded else { return }
        userQuotes.removeAll { $0.id == quote.id }
        rebuildAllQuotes()
        saveUserQuotes()
    }

    // MARK: - Private

    private func loadQuotes() {
        userQuotes = loadUserQuotes()
        rebuildAllQuotes()
    }

    private func rebuildAllQuotes() {
        allQuotes = PreloadedQuotes.quotes + userQuotes
    }

    private func loadUserQuotes() -> [Quote] {
        guard let data = UserDefaults.standard.data(forKey: Self.userQuotesKey),
              let quotes = try? JSONDecoder().decode([Quote].self, from: data) else {
            return []
        }
        return quotes
    }

    private func saveUserQuotes() {
        guard let data = try? JSONEncoder().encode(userQuotes) else { return }
        UserDefaults.standard.set(data, forKey: Self.userQuotesKey)
    }
}
