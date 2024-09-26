//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public extension Project {
    private static let environmentSettings = EnvironmentSettings.default
    private static let appName = environmentSettings.name
    private static let organizationName = environmentSettings.organizationName
    private static let defaultSettings = DefaultSettings.recommended(excluding: [
        "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
    ])
    
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
            settings: Configuration.noneSettings,
            targets: target,
            schemes: [
                .scheme(target: .debug, name: appName)
            ]
        )
    }
    
    static func module(
        name: String,
        options: Options = customOption,
        settings: Bool = false,
        targets: [Target]
    ) -> Project {
        return Project(
            name: name,
            organizationName: organizationName,
            options: options,
            settings: settings
            ? Configuration.getSetting(name: name)
            : Configuration.noneSettings,
            targets: targets,
            schemes: []
        )
    }
}
