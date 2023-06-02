// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum SharedIOSStrings {
  /// Shawty
  public static let appName = SharedIOSStrings.tr("Shared", "APP_NAME")
  /// Like a melody in my head...
  public static let appTagLine = SharedIOSStrings.tr("Shared", "APP_TAG_LINE")
  /// Something went wrong!
  public static let genericErrorTitle = SharedIOSStrings.tr("Shared", "GENERIC_ERROR_TITLE")
  /// Try a different search term?
  public static let noResultsSubtitle = SharedIOSStrings.tr("Shared", "NO_RESULTS_SUBTITLE")
  /// No results!
  public static let noResultsTitle = SharedIOSStrings.tr("Shared", "NO_RESULTS_TITLE")
  /// Still haven't found what you're looking for?
  public static let noSearchSubtitle = SharedIOSStrings.tr("Shared", "NO_SEARCH_SUBTITLE")
  /// Search for an artist
  public static let noSearchTitle = SharedIOSStrings.tr("Shared", "NO_SEARCH_TITLE")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension SharedIOSStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = SharedIOSResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
