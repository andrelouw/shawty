import ProjectDescription
import ProjectDescriptionHelpers

let name = "Artist"

let project = Project.featureModule(
  name: name,
  platform: .iOS.with(supportedPlatforms: .macOS),
  dependencies: [
    .foundation("Core"),
  ]
)
