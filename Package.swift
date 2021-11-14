// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinators",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Coordinators",
            targets: ["Coordinators"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "9.2.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift/", from: "6.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Coordinators",
            dependencies: ["RxSwift"]),
        .testTarget(
            name: "CoordinatorsTests",
            dependencies: [
                "Coordinators",
                "Quick",
                "Nimble"
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
