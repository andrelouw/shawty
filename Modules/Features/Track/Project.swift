import ProjectDescription
import ProjectDescriptionHelpers

let name = "Track"

let project = Project.featureModule(
  name: name,
  platform: .iOS.with(supportedPlatforms: .macOS),
  dependencies: [
    .foundation("Core"),
    .foundation("UI"),
    .foundation("Networking"),
    .feature("Shared"),
  ],
  additionalIOSDependencies: [
    .featureIOS("Shared"),
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