// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YBPopupMenu",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "YBPopupMenu",
            targets: ["YBPopupMenu"]),
    ],
    targets: [
        .target(
            name: "YBPopupMenu",
            dependencies: [],
            path: "YBPopupMenu",
            resources: [.copy("PrivacyInfo.xcprivacy")]
        )
    ]
)
