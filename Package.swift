// swift-tools-version: 6.0
import PackageDescription

// Cue follows the same layered structure as Prism (slpcc63/pulse):
// UI → services → domain, with storage behind repository interfaces.
// Phase 0 contains only the domain layer. Services, Persistence and
// Features targets are added in M1, together with the iPhone app target.
let package = Package(
    name: "Cue",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "CueDomain", targets: ["CueDomain"])
    ],
    targets: [
        .target(name: "CueDomain", path: "Cue/Domain"),
        .testTarget(name: "CueTests", dependencies: ["CueDomain"], path: "Cue/Tests")
    ]
)
