//
//  Project.swift
//  Config
//
//  Created by cha_nyeong on 9/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "DesignSystem",
    targets: [
        .make(
            name: "DesignSystem",
            product: .app,
            bundleId: "com.mashup.simi.designSystem",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "CFBunldeIconName": "AppIcon",
                    "ITSAppUsesNonExemptEncryption": "NO",
                    "ITSEncryptionExportComplianceCode": "false"
                ]
            ),
            sources: ["DesignSystem/Sources/**"],
            resources: ["DesignSystem/Resources/**"],
            dependencies: [
                .designSystem
            ],
            settings: .settings()
        ),
    ],
    schemes: [
        .scheme(
            name: "DesignSystem",
            buildAction: .buildAction(targets: ["DesignSystem"]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release)
        )
    ],
    resourceSynthesizers: [
        .assets(),
    ]
)
