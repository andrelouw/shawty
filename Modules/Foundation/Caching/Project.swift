import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.foundationModule(
  name: "Caching",
  platforms: [.iOS, .macOS],
  dependencies: [
    .foundation("Core"),
  ]
)
