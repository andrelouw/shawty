import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  name: "iOS",
  productName: "Shawty",
  platform: .iOS,
  dependencies: [
    .foundation("Core"),
    .foundation("UI"),
    .foundationIOS("UI"),
    .feature("Artist"),
    .feature("Shared"),
    .featureIOS("Artist"),
    .feature("Album"),
    .featureIOS("Album"),
    .feature("Track"),
    .featureIOS("Track"),
    .foundation("Caching"),
  ]
)
