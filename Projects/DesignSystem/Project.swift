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
            product: .staticLibrary,
            bundleId: "com.mashup.simi.designSystem",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "CFBunldeIconName": "AppIcon",
                    "ITSAppUsesNonExemptEncryption": "NO",
                    "ITSEncryptionExportComplianceCode": "false"
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
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
