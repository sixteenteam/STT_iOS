import ProjectDescription

let projectName = "WaIrony"
let organizationName = "twinkleSun"

let project = Project(
    name: projectName,
    organizationName: organizationName,
    targets: [
        .init(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "\(organizationName).\(projectName)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .file(path: Path("Support/Info.plist")),
            sources: ["Source/**"],
            resources: ["Resource/**"]
        )
    ]
)
