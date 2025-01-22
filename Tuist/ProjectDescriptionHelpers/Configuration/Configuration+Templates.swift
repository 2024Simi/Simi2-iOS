//
//  Configuration+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public extension Configuration {
    
    static let defaultConfiguration = Settings.settings(
        configurations: [
            .debug(name: .debug, xcconfig: .relativeToRoot("Projects/\(Environment.name)/Config/Secrets.xcconfig")),
            .release(name: .release, xcconfig: .relativeToRoot("Projects/\(Environment.name)/Config/Secrets.xcconfig")),
        ],
        defaultSettings: DefaultSettings.recommended
    )
    
//    static let defaultConfiguration = Settings.settings()
}

