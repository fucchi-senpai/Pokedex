// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "PokedexPackage",
            targets: ["Views", "Models"]
        )
    ],
    dependencies: [
        .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0"))
    ],
    targets: [
        .target(
            name: "Views",
            dependencies: ["Models"]
        ),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ]
        )
    ]
)
