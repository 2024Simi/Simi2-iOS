//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    target: [
        .appTarget(
            name: EnvironmentSettings.default.name,
            dependencies: [
                .coordinator(.simiApp),
                .coordinator(.homeCoordinator),
                .designSystem,
                .core(.service),
                .core(.model),
                .core(.common)
            ],
            infoPlist: true
        ),
    ]
)

