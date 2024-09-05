// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
          "Lottie": .framework,
          "kakao-ios-sdk": .framework,
          "swiftyJSON": .framework
        ]
    )
#endif

let package = Package(
    name: "Simi-iOS",
    dependencies: [
      .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0"),
      .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.22.6"),
      .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "5.0.2"),
    ]
)
