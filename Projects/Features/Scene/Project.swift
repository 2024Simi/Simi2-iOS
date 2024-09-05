//
//  Project.swift
//  Config
//
//  Created by cha_nyeong on 9/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Scene",
    targets: [
        .make(
            name: "Home",
            product: .staticLibrary,
            bundleId: "com.mashup.simi.home",
            sources: ["HomeScene/**"],
            dependencies: [
                .core(.common),
                .core(.model),
                .core(.service),
                .spm(.lottie),
                .designSystem,
            ]
        )
    ]
)
