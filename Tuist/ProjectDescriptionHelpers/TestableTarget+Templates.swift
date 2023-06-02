import ProjectDescription

extension TestableTarget {
  public static func foundation(_ name: String) -> TestableTarget {
    TestableTarget(
      target: .foundationTest(name),
      parallelizable: true,
      randomExecutionOrdering: true
    )
  }

  public static func feature(_ name: String) -> TestableTarget {
    TestableTarget(
      target: .featureTest(name),
      parallelizable: true,
      randomExecutionOrdering: true
    )
  }

  public static func app(_ name: String) -> TestableTarget {
    TestableTarget(
      target: .appTest(name),
      parallelizable: true,
      randomExecutionOrdering: true
    )
  }
}
