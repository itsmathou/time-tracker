// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Categories",
            targets: ["Categories"]),
        .library(
            name: "Utilities",
            targets: ["Utilities"]
        ),
        .library(
            name: "Models",
            targets: ["Models"]
        ),
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]
        ),
        .library(
            name: "Schedules",
            targets: ["Schedules"]
        ),
        .library(
            name: "Activity",
            targets: ["Activity"]
        ),
        .library(
            name: "Extensions",
            targets: ["Extensions"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Categories",
            dependencies: [
                "Models",
                "SharedUI",
                "Utilities"
            ]
        ),
        .testTarget(
            name: "CategoriesTests",
            dependencies: ["Categories"]
        ),
        .target(
            name: "Utilities",
            dependencies: ["Extensions", "Models"]
        ),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]
        ),
        .target(
            name: "Models",
            dependencies: []
        ),
        .testTarget(
            name: "ModelsTests",
            dependencies: ["Models"]
        ),
        .target(
            name: "SharedUI",
            dependencies: []
        ),
        .testTarget(
            name: "SharedUITests",
            dependencies: ["SharedUI"]
        ),
        .target(
            name: "Schedules",
            dependencies: ["Activity"]
        ),
        .testTarget(
            name: "SchedulesTests",
            dependencies: ["Schedules"]
        ),
        .target(
            name: "Activity",
            dependencies: ["Models", "Utilities"]
        ),
        .testTarget(
            name: "ActivityTests",
            dependencies: ["Activity"]
        ),
        .target(
            name: "Extensions",
            dependencies: []
        ),
        .testTarget(
            name: "ExtensionsTests",
            dependencies: ["Extensions"]
        ),
    ]
)
