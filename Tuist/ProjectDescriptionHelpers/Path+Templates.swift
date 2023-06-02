import ProjectDescription

extension Path {
  public static func foundation(_ path: String) -> Path {
    .relativeToRoot("Modules/Foundation/\(path)")
  }

  public static func feature(_ path: String) -> Path {
    .relativeToRoot("Modules/Features/\(path)")
  }

  public static func app(_ path: String) -> Path {
    .relativeToRoot("Apps/\(path)")
  }
}
