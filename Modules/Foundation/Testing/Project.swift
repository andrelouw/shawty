import ProjectDescription
import ProjectDescriptionHelpers

let name = "Testing"

let project = Project(
  name: name,
  options: .options(
    automaticSchemesOptions: .disabled
  ),
  targets: [
    .makeFrameworkTarget(
      name: name,
      platform: .iOS.with(supportedPlatforms: .macOS),
      hasResources: false,
      dependencies: [
        .foundation("Core"),
        .xctest,
      ]
    ),
    .makeTestTarget(
      name: name,
      platform: .iOS.with(supportedPlatforms: .macOS),
      dependencies: [
        .target(name: name),
      ]
    ),
  ]
)
