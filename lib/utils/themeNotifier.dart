import 'package:flutter/material.dart';

class ThemeNotifier extends InheritedWidget {
  final bool isDarkMode;
  final ValueChanged<bool> toggleTheme;

  const ThemeNotifier({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeNotifier? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeNotifier>();
  }

  @override
  bool updateShouldNotify(ThemeNotifier oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}
