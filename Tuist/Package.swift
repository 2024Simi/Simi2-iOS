// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        productTypes: [:]
    )
#endif

let package = Package(
    name: "Simi-iOS",
    dependencies: [
      .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0"),
      .package(url: "https://github.com/kakao/kakao-ios-sdk.git", from: "2.20.0"),
      .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "5.0.2"),
    ]
)
