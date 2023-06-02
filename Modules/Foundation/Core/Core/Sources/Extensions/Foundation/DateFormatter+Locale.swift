import Foundation

extension DateFormatter {
  public static func localeFullDayMonthYear() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("dd MMMM YYYY")
    return formatter
  }
}
