//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let module = Project.module(
    name: "Core",
    settings: true,
    targets: [
        .multiTarget(
            name: "Common",
            product: .staticLibrary,
            resources: false,
            dependencies: [],
            infoPlist: true,
            setting: true
        ),
        .multiTarget(
            name: "Models",
            product: .framework,
            resources: false,
            dependencies: [],
            infoPlist: true,
            setting: false
        ),
        .multiTarget(
            name: "Services",
            product: .staticLibrary,
            resources: false,
            dependencies: [
                .spm(.lottie),
                .spm(.kakaoIosSdk),
            ],
            infoPlist: true,
            setting: true
        )
    ]
)
