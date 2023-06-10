import ProjectDescription
import ProjectDescriptionHelpers

let name = "UI"

let project = Project(
  name: name,
  options: .options(
    automaticSchemesOptions: .disabled
  ),
  targets: [
    .makeFrameworkTarget(
      name: name,
      platform: .iOS.with(supportedPlatforms: .macOS),
      hasResources: true,
      dependencies: [
        .foundation("Core"),
      ]
    ),
    .makeTestTarget(
      name: name,
      platform: .iOS.with(supportedPlatforms: .macOS),
      dependencies: [
        .target(name: name),
      ]
    ),
    .makeFrameworkTarget(
      name: "\(name)IOS",
      platform: .iOS,
      hasResources: true,
      dependencies: [
        .target(name: name),
        .foundation("Core"),
      ]
    ),
    .makeTestTarget(
      name: "\(name)IOS",
      platform: .iOS,
      dependencies: [
        .target(name: "\(name)IOS"),
      ]
    ),
  ],
  fileHeaderTemplate: .string("")
)
