import Foundation

/// How much it matters to resolve an unknown.
public enum Importance: Int, Hashable, Comparable, Sendable, CaseIterable {
    case veryLow = 0
    case low, medium, high, veryHigh

    public static func < (lhs: Importance, rhs: Importance) -> Bool { lhs.rawValue < rhs.rawValue }
}

/// A missing fact. Cue never invents an answer: an unknown stays unknown
/// until the user answers or evidence resolves it.
public struct Unknown: Hashable, Sendable, Identifiable {
    public let id: UUID
    /// The question in plain words, e.g. "Has lunch been packed?"
    public var question: String
    public var importance: Importance

    public init(id: UUID = UUID(), question: String, importance: Importance) {
        self.id = id
        self.question = question
        self.importance = importance
    }
}
