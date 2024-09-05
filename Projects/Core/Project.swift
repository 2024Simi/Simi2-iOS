//
//  Project.swift
//  Config
//
//  Created by cha_nyeong on 9/5/24.
//
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Core",
    targets: [
        .make(
            name: "Common",
            product: .staticLibrary,
            bundleId: "com.mashup.simi.common",
            sources: ["Common/**"],
            dependencies: []
        ),
        .make(
            name: "Models",
            product: .staticLibrary,
            bundleId: "com.mashup.simi.models",
            sources: ["Models/**"],
            dependencies: []
        ),
        .make(
            name: "Services",
            product: .staticLibrary,
            bundleId: "com.mashup.simi.services",
            sources: ["Services/**"],
            dependencies: []
        )
        // 각 부분 필요한 의존성 필요시 추가 진행
    ]
)
