//
//  Project+Extensions.swift
//  Config
//
//  Created by cha_nyeong on 9/5/24.
//

import ProjectDescription

extension Project {
    public static func make(
        name: String,
        packages: [Package] = [],
        targets: [Target],
        schemes: [Scheme] = [],
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) -> Project {
        return Project(
            name: name,
            organizationName: "simi.simi-iOS",
            options: .options(
                automaticSchemesOptions: .disabled,
                defaultKnownRegions: ["en", "ko"],
                developmentRegion: "ko",
                textSettings: .textSettings(usesTabs: false, indentWidth: 4, tabWidth: 4)
            ),
            packages: packages,
            settings: .settings(base: ["IPHONEOS_DEPLOYMENT_TARGET": "17.0"]),
            targets: targets,
            schemes: schemes,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
