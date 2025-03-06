//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public extension Target {
    private static let appName = Environment.name
    private static let organizationName = Environment.organizationName
    private static let destinations = Environment.destinations
    private static let deploymentTargets = Environment.deploymentTargets
    
    static func moduleTarget(
        name: String,
        product: Product = .staticLibrary,
        resources: Bool = false,
        dependencies: [Module] = [], 
        setting: Bool = false,
        mergedBinaryType: MergedBinaryType = .disabled,
        mergeable: Bool = false
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "com.\(organizationName).\(name)",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: resources ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: Configuration.defaultConfiguration,
            mergedBinaryType: mergedBinaryType,
            mergeable: mergeable
        )
    }
    
    static func multiTarget(
        name: String,
        product: Product,
        resources: Bool = false,
        dependencies: [Module] = [],
        setting: Bool = false,
        mergedBinaryType: MergedBinaryType = .disabled,
        mergeable: Bool = false
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "com.\(organizationName).\(name)",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["\(name)/Sources/**"],
            resources: resources ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: Configuration.defaultConfiguration,
            mergedBinaryType: mergedBinaryType,
            mergeable: mergeable
        )
    }
    
    static func appTarget(
        name: String,
        dependencies: [Module] = []
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.\(name).\(organizationName)",
            deploymentTargets: deploymentTargets,
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            //            entitlements: "\(name).entitlements", // 추가 후 주석 해제
            dependencies: dependencies,
            settings: Configuration.defaultConfiguration
        )
    }
}
