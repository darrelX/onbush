import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

extension ThemeDataX on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension MediaQueryX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get width => screenSize.width;
  double get height => screenSize.height;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension AppLocalizationX on BuildContext {
  AppLocalizations get appLocalization => AppLocalizations.of(this)!;
}

extension DateTimeExtensions on DateTime {
  /// Retourne la différence entre `this` et une autre [DateTime] sous forme de texte (ex: "2h", "5j", "1m").
  String timeAgoShort({DateTime? compareTo}) {
    final DateTime now = compareTo ?? DateTime.now();
    final Duration diff = now.difference(this);

    if (diff.inMinutes < 1) {
      return "À l'instant";
    } else if (diff.inHours < 1) {
      return "${diff.inMinutes}m";
    } else if (diff.inDays < 1) {
      int hours = diff.inHours;
      int minutes = diff.inMinutes % 60;
      return minutes > 0 ? "${hours}h${minutes}m" : "${hours}h";
    } else if (diff.inDays < 30) {
      return "${diff.inDays}j";
    } else if (diff.inDays < 365) {
      return "${diff.inDays ~/ 30}m";
    } else {
      return "${diff.inDays ~/ 365}a";
    }
  }
}

