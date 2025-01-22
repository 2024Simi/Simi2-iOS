//
//  Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public struct Environment {
    public static let name: String = "SimiApp"
    public static let organizationName: String = "inner-dev"
    public static let deploymentTargets: DeploymentTargets = .iOS("17.0")
    public static let destinations: Destinations = .iOS
}
