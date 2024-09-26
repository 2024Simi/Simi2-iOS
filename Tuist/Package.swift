// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
//        productTypes: [
//          "Lottie": .framework,
//          "kakao-ios-sdk": .staticLibrary,
//          "swiftyJSON": .framework
//        ]
        productTypes: [:],
        baseSettings: .settings(
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ]
        )
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
