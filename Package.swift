// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = Version("1.41.0")

let gitUrl = "https://raw.githubusercontent.com/SumSubstance/IdensicMobileSDK-iOS-Release/master/\(version)"
let mavenUrl = "https://maven.sumsub.com/repository/maven-private"

enum checksums {
    static let eid = "fb64064ebaac99f664716dff2b1aa357970a76c8bf7f240669a767166d693612"
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
