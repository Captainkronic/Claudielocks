import Foundation

struct Quote: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let author: String
    let isPreloaded: Bool

    init(id: UUID = UUID(), text: String, author: String, isPreloaded: Bool = false) {
        self.id = id
        self.text = text
        self.author = author
        self.isPreloaded = isPreloaded
    }
}
