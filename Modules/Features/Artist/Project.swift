import ProjectDescription
import ProjectDescriptionHelpers

let name = "Artist"

let project = Project.featureModule(
  name: name,
  platform: .iOS.with(supportedPlatforms: .macOS),
  exampleAppPlatform: .iOS,
  dependencies: [
    .foundation("Core"),
    .foundation("UI"),
    .foundation("Networking"),
  ],
  additionalTargets: [
    .makeTestTarget(
      name: "\(name)APIIntegration",
      platform: .iOS.with(supportedPlatforms: .macOS),
      dependencies: [
        .target(name: name),
      ]
    ),
  ],
  additionalTestDependencies: [
    .project(target: "NetworkTesting", path: .relativeToRoot("Modules/Foundation/Networking/")),
  ]
)
