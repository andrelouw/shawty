import ProjectDescription
import ProjectDescriptionHelpers

let name = "Networking"

let project = Project.foundationModule(
  name: name,
  platforms: [.iOS, .macOS],
  dependencies: [
    .foundation("Core"),
  ],
  additionalTargets: [
    .makeFrameworkTarget(
      name: "NetworkTesting",
      platform: .iOS.with(supportedPlatforms: .macOS),
      hasResources: false,
      dependencies: [
        .foundation("Core"),
        .foundation(name),
        .xctest,
      ]
    ),
  ],
  additionalTestDependencies: [
    .project(target: "NetworkTesting", path: .relativeToRoot("Modules/Foundation/\(name)/")),
  ]
)
