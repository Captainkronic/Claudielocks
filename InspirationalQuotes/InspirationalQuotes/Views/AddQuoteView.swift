import SwiftUI

struct AddQuoteView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var quoteText = ""
    @State private var authorText = ""

    let onSave: (String, String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Quote") {
                    TextEditor(text: $quoteText)
                        .frame(minHeight: 100)
                }

                Section("Author") {
                    TextField("Author name", text: $authorText)
                }
            }
            .navigationTitle("Add Quote")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmedText = quoteText.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedAuthor = authorText.trimmingCharacters(in: .whitespacesAndNewlines)
                        onSave(trimmedText, trimmedAuthor.isEmpty ? "Unknown" : trimmedAuthor)
                        dismiss()
                    }
                    .disabled(quoteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
