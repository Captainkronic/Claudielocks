import SwiftUI

struct RemoveQuotesView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: QuoteStore

    var body: some View {
        NavigationStack {
            Group {
                if store.userQuotes.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "text.quote")
                            .font(.system(size: 48))
                            .foregroundStyle(.tertiary)
                        Text("No custom quotes yet")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("Quotes you add will appear here\nand can be removed by swiping.")
                            .font(.subheadline)
                            .foregroundStyle(.tertiary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(store.userQuotes) { quote in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(quote.text)
                                    .font(.body)
                                    .lineLimit(3)
                                Text("— \(quote.author)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { offsets in
                            store.deleteUserQuote(at: offsets)
                        }
                    }
                }
            }
            .navigationTitle("Your Quotes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
