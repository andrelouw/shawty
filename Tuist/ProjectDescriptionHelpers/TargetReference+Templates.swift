import ProjectDescription

extension TargetReference {
  public static func foundation(_ name: String) -> TargetReference {
    TargetReference(projectPath: .foundation(name), target: name)
  }

  public static func foundationTest(_ name: String) -> TargetReference {
    TargetReference(projectPath: .foundation(name), target: "\(name)Tests")
  }

  public static func feature(_ name: String) -> TargetReference {
    TargetReference(projectPath: .feature(name), target: name)
  }

  public static func featureTest(_ name: String) -> TargetReference {
    TargetReference(projectPath: .feature(name), target: "\(name)Tests")
  }

  public static func app(_ name: String) -> TargetReference {
    TargetReference(projectPath: .app(name), target: "\(name)App")
  }

  public static func appTest(_ name: String) -> TargetReference {
    TargetReference(projectPath: .app(name), target: "\(name)AppTests")
  }
}
