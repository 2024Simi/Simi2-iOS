//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let module = Project.module(
    name: "Coordinator",
    targets: [
        .moduleTarget(
            name: "AppCoordinator",
            product: .staticLibrary,
            resources: false,
            dependencies: [
                .scene(.home)
            ],
            infoPlist: false
        )
    ]
)
