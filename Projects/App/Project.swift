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
                .coordinator(.app),
                .designSystem
            ],
            infoPlist: true
        ),
    ]
)

