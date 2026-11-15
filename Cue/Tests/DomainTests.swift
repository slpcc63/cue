import CueDomain
import Foundation
import Testing

struct ConfidenceTests {
    @Test(arguments: [(-0.5, 0.0), (0.0, 0.0), (0.42, 0.42), (1.0, 1.0), (7.0, 1.0)])
    func clampsToZeroThroughOne(_ input: Double, _ expected: Double) {
        #expect(Confidence(input).value == expected)
    }

    @Test func notANumberBecomesUnknown() {
        #expect(Confidence(.nan) == .unknown)
    }

    @Test func ordersByValue() {
        #expect(Confidence(0.3) < Confidence(0.9))
    }
}

struct BeliefTests {
    @Test func keepsItsSource() {
        let belief = Belief(
            subject: "intent", statement: "Cooking",
            confidence: Confidence(0.91), source: .user,
            observedAt: Date(timeIntervalSince1970: 0))
        #expect(belief.source == .user)
        #expect(belief.confidence.value == 0.91)
    }
}

struct UnknownTests {
    @Test func importanceIsOrdered() {
        #expect(Importance.veryHigh > Importance.low)
    }
}
