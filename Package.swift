// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = Version("1.34.0")
let aalVersion = Version("1.3.3")
let coreVersion = Version(version.major, version.minor, version.patch, prereleaseIdentifiers: ["noeid"])

let gitUrl = "https://raw.githubusercontent.com/SumSubstance/IdensicMobileSDK-iOS-Release/master/\(version)"
let mavenUrl = "https://maven.sumsub.com/repository/maven-private"

enum checksums {

    static let eid  = "898355e98e00f38eceb41d92500432111faf72d3c7603568d6b12495a92727b3"
    static let aal  = "91ce5ab93756d4c664444bbf19b7d03b78024936873b97fc0bd45aa5a141f0a0"

}

let package = Package(
    name: "IdensicMobileSDK_EID",
    platforms: [
        .iOS("12.2")
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
        .package(url: "https://github.com/SumSubstance/IdensicMobileSDK-iOS.git", .exact(coreVersion))
    ],
    targets: [
        .binaryTarget(
            name: "IdensicMobileSDK_EID",
            url: "\(gitUrl)/IdensicMobileSDK_EID-\(version).zip",
            checksum: checksums.eid
        ),
        .binaryTarget(
            name: "AuthadaAuthenticationLibrary",
            url: "\(mavenUrl)/de/authada/library/aal-ios/\(aalVersion)/aal-ios-\(aalVersion).zip",
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
