//
//  Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public struct EnvironmentSettings {
    public let name: String
    public let organizationName: String
    public let deploymentTargets: DeploymentTargets
    public let platform: Platform
    public let destinations: Destinations
    
    public static let `default` = EnvironmentSettings(
        name: "App", 
        organizationName: "inner-dev",
        deploymentTargets: .iOS("17.0"),
        platform: .iOS,
        destinations: [.iPhone]
    )
}
