//
//  Project.swift
//  AppManifests
//
//  Created by cha_nyeong on 9/5/24.
//
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Coordinator",
    targets: [
        .make(
                   name: "AppCoordinator",
                   product: .staticLibrary,
                   bundleId: "com.mashup.simi.appCoordinator",
                   sources: ["AppCoordinator/**"],
                   dependencies: [
                   ]
               )
        ]
    )
