import ProjectDescription

extension Project {
  public static func app(
    name: String,
    productName: String? = nil,
    platform: Platform,
    dependencies: [TargetDependency] = []
  ) -> Project {
    Project(
      name: name,
      options: .options(
        automaticSchemesOptions: .disabled
      ),
      targets: [
        .makeAppTarget(
          name: name,
          productName: productName,
          platform: platform,
          dependencies: dependencies
        ),
        .makeTestTarget(
          name: "\(name)App",
          platform: platform.asPlatformSet(),
          dependencies: [
            .target(name: "\(name)App"),
          ]
        ),
        .makeUITestTarget(
          name: "\(name)App",
          platform: platform.asPlatformSet(),
          dependencies: [
            .target(name: "\(name)App"),
          ]
        ),
      ],
      fileHeaderTemplate: .string("")
    )
  }

  public static func foundationModule(
    name: String,
    platforms: [Platform],
    hasResources: Bool = false,
    dependencies: [TargetDependency] = [],
    additionalTargets: [Target] = [],
    additionalTestDependencies: [TargetDependency] = []
  ) -> Project {
    foundationModule(
      name: name,
      platform: platforms.asPlatformSet(),
      hasResources: hasResources,
      dependencies: dependencies,
      additionalTargets: additionalTargets,
      additionalTestDependencies: additionalTestDependencies
    )
  }

  public static func foundationModule(
    name: String,
    platform: PlatformSet,
    hasResources: Bool = false,
    dependencies: [TargetDependency] = [],
    additionalTargets: [Target] = [],
    additionalTestDependencies: [TargetDependency] = []
  ) -> Project {
    Project(
      name: name,
      options: .options(
        automaticSchemesOptions: .disabled
      ),
      targets: [
        .makeFrameworkTarget(
          name: name,
          platform: platform,
          hasResources: hasResources,
          dependencies: dependencies
        ),
        .makeTestTarget(
          name: name,
          platform: platform,
          dependencies: [
            .target(name: name),
          ] + additionalTestDependencies
        ),
      ] + additionalTargets,
      fileHeaderTemplate: .string("")
    )
  }

  public static func featureModule(
    name: String,
    platforms: [Platform],
    exampleAppPlatform: Platform? = nil,
    dependencies: [TargetDependency] = [],
    additionalIOSDependencies: [TargetDependency] = [],
    additionalTargets: [Target] = [],
    additionalTestDependencies: [TargetDependency] = []
  ) -> Project {
    featureModule(
      name: name,
      platform: platforms.asPlatformSet(),
      exampleAppPlatform: exampleAppPlatform,
      dependencies: dependencies,
      additionalIOSDependencies: additionalIOSDependencies,
      additionalTargets: additionalTargets,
      additionalTestDependencies: additionalTestDependencies
    )
  }

  public static func featureModule(
    name: String,
    platform: PlatformSet,
    exampleAppPlatform: Platform? = nil,
    dependencies: [TargetDependency] = [],
    additionalIOSDependencies: [TargetDependency] = [],
    additionalTargets: [Target] = [],
    additionalTestDependencies: [TargetDependency] = []
  ) -> Project {
    let appPlatform = exampleAppPlatform ?? platform.base

    return Project(
      name: name,
      options: .options(
        automaticSchemesOptions: .disabled
      ),
      targets: [
        .makeFrameworkTarget(
          name: name,
          platform: platform,
          dependencies: dependencies
        ),
        .makeTestTarget(
          name: name,
          platform: platform,
          dependencies: [
            .target(name: name),
          ] + additionalTestDependencies
        ),
        .makeFrameworkTarget(
          name: "\(name)IOS",
          platform: .iOS,
          hasResources: true,
          dependencies: dependencies + [.target(name: name)] + additionalIOSDependencies
        ),
        .makeTestTarget(
          name: "\(name)IOS",
          platform: .iOS,
          dependencies: [
            .target(name: "\(name)IOS"),
          ]
        ),
        .makeAppTarget(
          name: name,
          productName: "\(name)App",
          platform: .iOS,
          dependencies: [
            .target(name: "\(name)IOS"),
          ]
        ),
      ] + additionalTargets,
      schemes: [
        Scheme(
          name: name,
          buildAction: .buildAction(
            targets: [
              .project(path: .relativeToManifest("."), target: name),
            ]
          ),
          testAction: .targets(
            [
              TestableTarget(
                target: .project(path: .relativeToManifest("."), target: "\(name)Tests"),
                parallelizable: true,
                randomExecutionOrdering: true
              ),
            ],
            attachDebugger: false
          )
        ),
        Scheme(
          name: "\(name)IOS",
          buildAction: .buildAction(
            targets: [
              .project(path: .relativeToManifest("."), target: name),
              .project(path: .relativeToManifest("."), target: "\(name)IOS"),
            ]
          ),
          testAction: .targets(
            [
              TestableTarget(
                target: .project(path: .relativeToManifest("."), target: "\(name)Tests"),
                parallelizable: true,
                randomExecutionOrdering: true
              ),
              TestableTarget(
                target: .project(path: .relativeToManifest("."), target: "\(name)IOSTests"),
                parallelizable: true,
                randomExecutionOrdering: true
              ),
            ],
            attachDebugger: false
          ),
          runAction: .runAction(
            executable: .project(path: .relativeToManifest("."), target: "\(name)App")
          )
        ),
      ],
      fileHeaderTemplate: .string("")
    )
  }
}
