//
//  Project.swift
//  Config
//
//  Created by cha_nyeong on 9/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "App",
    targets: [
        .make(
            name: "Simi-iOS",
            product: .app,
            bundleId: "com.simi.simi-iOS",
            infoPlist: .file(path: .relativeToRoot("Projects/App/InfoPlists/Info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: .relativeToRoot("Projects/App/Entitlements/Simi-iOS.entitlements")),
            scripts: [],
            dependencies: [
                .coordinator(.app),
            ],
            settings: .settings(
                configurations: [],
                defaultSettings: .recommended(excluding: ["앱 아이콘 이름"])
            )
        ),
    ],
    additionalFiles: []
)
