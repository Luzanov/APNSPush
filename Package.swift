// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "APNSPush",
    platforms: [
        .macOS(.v10_13)
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/BlueECC.git", from: "1.2.4")
    ],
    targets: [
        .target(name: "APNSPush",
                dependencies: [.byName(name: "CryptorECC")
        ])
    ]
)
