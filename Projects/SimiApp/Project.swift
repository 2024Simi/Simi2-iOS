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
            name: Environment.name,
            dependencies: [
                .coordinator(.homeCoordinator),
                .coordinator(.recordCoordinator),
                .designSystem,
                .core(.service),
                .core(.model),
                .core(.common)
            ]
        ),
    ]
)

