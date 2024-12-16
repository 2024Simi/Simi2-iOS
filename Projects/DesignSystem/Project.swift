//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let module = Project.module(
    name: "DesignSystem",
    targets: [
        .moduleTarget(
            name: "DesignSystem",
            product: .framework,
            resources: true,
            dependencies: [.spm(.lottie)],
            infoPlist: true
        )
    ]
)

