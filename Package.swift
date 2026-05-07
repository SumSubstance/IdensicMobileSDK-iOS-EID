// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = Version("1.44.0")

let gitUrl = "https://maven.sumsub.com/repository/releases/IdensicMobileSDK-iOS/\(version)"
let mavenUrl = "https://maven.sumsub.com/repository/maven-private"

enum checksums {
    static let eid = "96ea05c5eaf668d6081f5448e2ca98e708e0dc9caead9e1f91612bca99a2b6d7"
    static let aal = "c7fc02056555a0b5876f6ad8e91afff4fa35d5b9f204a1d83b7347bd0fc4f6b2"
}

let package = Package(
    name: "IdensicMobileSDK_EID",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "IdensicMobileSDK_EID",
            targets: [
                "EIDWrapper"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SumSubstance/IdensicMobileSDK-iOS.git", .exact(version))
    ],
    targets: [
        .binaryTarget(
            name: "IdensicMobileSDK_EID",
            url: "\(gitUrl)/IdensicMobileSDK_EID-\(version).zip",
            checksum: checksums.eid
        ),
        .binaryTarget(
            name: "AuthadaAuthenticationLibrary",
            url: "\(mavenUrl)/de/authada/library/aal-ios/1.3.4/aal-ios-1.3.4.zip",
            checksum: checksums.aal
        ),
        .target(
            name: "EIDWrapper",
            dependencies: [
                .product(name: "IdensicMobileSDK", package: "IdensicMobileSDK-iOS"),
                "IdensicMobileSDK_EID",
                "AuthadaAuthenticationLibrary"
            ],
            path: "EIDWrapper"
        )
    ]
)
