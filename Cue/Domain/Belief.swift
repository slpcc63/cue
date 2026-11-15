import Foundation

/// How sure Cue is about something, from 0 (no idea) to 1 (certain).
/// Values outside that range are clamped.
public struct Confidence: Hashable, Comparable, Sendable {
    public let value: Double

    public init(_ value: Double) {
        if value.isNaN {
            self.value = 0
        } else {
            self.value = min(max(value, 0), 1)
        }
    }

    public static let unknown = Confidence(0)
    public static let certain = Confidence(1)

    public static func < (lhs: Confidence, rhs: Confidence) -> Bool { lhs.value < rhs.value }
}

/// Where a belief came from. Every belief records its source so that new
/// sources (such as Prism) plug in later without redesigning the world model.
public enum BeliefSource: String, Hashable, Sendable, CaseIterable {
    /// The user told Cue directly (a tap or an answer).
    case user
    /// Read from the phone's calendar.
    case calendar
    /// Read from the phone's clock or sensors.
    case device
    /// Imported from Prism observations (Phase 2).
    case prism
    /// Concluded by Cue from other beliefs.
    case inferred
}

/// Something Cue currently believes, never a permanent fact.
public struct Belief: Hashable, Sendable, Identifiable {
    public let id: UUID
    /// What the belief is about, e.g. "intent" or "location".
    public var subject: String
    /// The belief in plain words, e.g. "Cooking".
    public var statement: String
    public var confidence: Confidence
    public var source: BeliefSource
    /// When the evidence for this belief was observed.
    public var observedAt: Date

    public init(
        id: UUID = UUID(), subject: String, statement: String,
        confidence: Confidence, source: BeliefSource, observedAt: Date
    ) {
        self.id = id
        self.subject = subject
        self.statement = statement
        self.confidence = confidence
        self.source = source
        self.observedAt = observedAt
    }
}
