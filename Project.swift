import ProjectDescription

let projectName = "WaIrony"
let organizationName = "twinkleSun"

let project = Project(
    name: projectName,
    organizationName: organizationName,
    packages: [
        .remote(
            url: "https://github.com/Mercen-Lee/FlowKit.git",
            requirement: .branch("main")
        ),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk.git", requirement: .branch("master"))
    ], 
    settings: .settings(base: ["OTHER_LDFLAGS": .string("$(inherited) -all_load")]),
    targets: [
        .init(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "\(organizationName).\(projectName)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .file(path: Path("Support/Info.plist")),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            dependencies: [
                .package(product: "FlowKit"),
                .package(product: "KakaoSDKCommon"),
                .package(product: "KakaoSDKAuth"),
                .package(product: "KakaoSDKUser")
            ]
        )
    ]
)
