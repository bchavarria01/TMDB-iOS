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
  /// Cancel
  internal static let cancelAction = L10n.tr("Localizable", "cancelAction")
  /// Cast
  internal static let cast = L10n.tr("Localizable", "cast")
  /// Created by 
  internal static let createdBy = L10n.tr("Localizable", "createdBy")
  /// Ha ocurrido un error, por favor intente nuevamente más tarde
  internal static let defaultErrorMessage = L10n.tr("Localizable", "defaultErrorMessage")
  /// Status code didn't fall withing the given range
  internal static let defaultMoyaErrorMessage = L10n.tr("Localizable", "defaultMoyaErrorMessage")
  /// Ha ocurrido un error inesperado intenta nuevamente.
  internal static let errorHasOcurred = L10n.tr("Localizable", "errorHasOcurred")
  /// Rick is a mentally-unbalanced but scientifically-gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.
  internal static let exampleText = L10n.tr("Localizable", "exampleText")
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
  /// Estos no parecen ser datos válidos.
  internal static let notValidData = L10n.tr("Localizable", "notValidData")
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
  /// La sesión ha expirado.
  internal static let sessionHasExpired = L10n.tr("Localizable", "sessionHasExpired")
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
