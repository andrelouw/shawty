// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum AlbumIOSStrings {
  /// Released: %@
  public static func albumReleasedDate(_ p1: Any) -> String {
    return AlbumIOSStrings.tr("Album", "ALBUM_RELEASED_DATE %@", String(describing: p1))
  }
  /// Albums
  public static let albumSearchScreenTitle = AlbumIOSStrings.tr("Album", "ALBUM_SEARCH_SCREEN_TITLE")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension AlbumIOSStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = AlbumIOSResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
