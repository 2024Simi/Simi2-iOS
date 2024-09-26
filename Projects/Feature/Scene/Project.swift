//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let module = Project.module(
    name: "Scene",
    settings: true,
    targets: [
        .moduleTarget(
            name: "Home",
            product: .staticLibrary,
            resources: false,
            dependencies: [
                .core(.service),
                .core(.model),
                .designSystem
            ],
            infoPlist: true
        )
    ]
)

