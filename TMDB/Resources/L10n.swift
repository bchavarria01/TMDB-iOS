// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Airing Today
  internal static let airingOption = L10n.tr("Localizable", "airingOption")
  /// Back
  internal static let backAction = L10n.tr("Localizable", "backAction")
  /// Cancel
  internal static let cancelAction = L10n.tr("Localizable", "cancelAction")
  /// Cast
  internal static let cast = L10n.tr("Localizable", "cast")
  /// Created by 
  internal static let createdBy = L10n.tr("Localizable", "createdBy")
  /// Favorite Shows
  internal static let favoriteShows = L10n.tr("Localizable", "favoriteShows")
  /// TV Show
  internal static let homeTitle = L10n.tr("Localizable", "homeTitle")
  /// Last Season
  internal static let lastSeason = L10n.tr("Localizable", "lastSeason")
  /// Log in
  internal static let loginAction = L10n.tr("Localizable", "loginAction")
  /// Log Out
  internal static let logOut = L10n.tr("Localizable", "logOut")
  /// Sorry\n You should have an internet connection to view this content
  internal static let noInternetConnection = L10n.tr("Localizable", "noInternetConnection")
  /// On TV
  internal static let onTvOption = L10n.tr("Localizable", "onTvOption")
  /// What do you want to do?
  internal static let optionsQustion = L10n.tr("Localizable", "optionsQustion")
  /// Password
  internal static let passwordPlaceholder = L10n.tr("Localizable", "passwordPlaceholder")
  /// Popular
  internal static let popularOption = L10n.tr("Localizable", "popularOption")
  /// Profile
  internal static let profileTitle = L10n.tr("Localizable", "profileTitle")
  /// Summary
  internal static let summary = L10n.tr("Localizable", "summary")
  /// Top Rated
  internal static let topRatedOption = L10n.tr("Localizable", "topRatedOption")
  /// Username
  internal static let usernamePlaceholder = L10n.tr("Localizable", "usernamePlaceholder")
  /// View All Seasons
  internal static let viewAllSeasonActiom = L10n.tr("Localizable", "viewAllSeasonActiom")
  /// View Profile
  internal static let viewProfile = L10n.tr("Localizable", "viewProfile")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type
