//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public extension Project {
    private static let appName = Environment.name
    private static let organizationName = Environment.organizationName
    
    static let customOption: Options = .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    )
    
    static func app(
        target: [Target]
    ) -> Project {
        return Project(
            name: appName,
            organizationName: organizationName,
            options: customOption,
            settings: Configuration.defaultConfiguration,
            targets: target,
            schemes: .app
        )
    }
    
    static func module(
        name: String,
        options: Options = customOption,
        settings: Bool = false,
        targets: [Target]
    ) -> Project {
        let debugScheme = Scheme.scheme(
            schemeName: "\(name)Debug",
            targetName: name,
            configurationName: .debug
        )

        let releaseScheme = Scheme.scheme(
            schemeName: "\(name)Release",
            targetName: name,
            configurationName: .release
        )
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: options,
            settings: Configuration.defaultConfiguration,
            targets: targets,
            schemes: [debugScheme, releaseScheme]
        )
    }
}
