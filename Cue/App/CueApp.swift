import CueDomain
import SwiftUI

@main struct CueApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

/// Phase 0 placeholder. In M1 this card is filled by the decision engine:
/// one recommendation, plus a "Why?" that shows the beliefs behind it.
struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Cue")
                    .font(.largeTitle.bold())
                NextCard(
                    action: "Nothing to do yet.",
                    detail: "This is Phase 0. In M1, this card will tell you when to leave for your next shift."
                )
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct NextCard: View {
    let action: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("NEXT")
                .font(.caption.weight(.semibold))
                .tracking(1.5)
                .foregroundStyle(.secondary)
            Text(action)
                .font(.title2.weight(.semibold))
            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 4)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(.secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .shadow(color: .black.opacity(0.06), radius: 12, y: 4)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    HomeView()
}
